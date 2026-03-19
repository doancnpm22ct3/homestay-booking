<template>
  <div class="fixed inset-0 bg-black/60 z-[60] flex items-center justify-center p-4" @click.self="$emit('close')">
    <div class="bg-white rounded-2xl shadow-2xl w-full max-w-md p-6">
      <h3 class="text-lg font-bold text-gray-800 mb-4">🚪 Xác nhận Check-out</h3>

      <!-- Cảnh báo trả phòng sớm -->
      <div v-if="isEarlyWarning" class="mb-4 p-4 bg-amber-50 border border-amber-200 rounded-xl">
        <div class="flex items-start gap-2">
          <span class="text-amber-500 text-xl">⚠️</span>
          <div>
            <p class="font-semibold text-amber-800">Khách trả phòng sớm!</p>
            <p class="text-sm text-amber-700 mt-1">
              Ngày check-out theo hợp đồng là <strong>{{ fmtDateStr(booking.check_out_date) }}</strong>,
              nhưng hôm nay mới là <strong>{{ todayStr }}</strong>.
            </p>
            <label class="flex items-center gap-2 mt-3 cursor-pointer select-none">
              <input type="checkbox" v-model="earlyConfirmed" class="w-4 h-4 accent-amber-500" />
              <span class="text-sm font-medium text-amber-900">
                Tôi xác nhận khách trả phòng sớm và đã thỏa thuận về chính sách hoàn/phạt.
              </span>
            </label>
          </div>
        </div>
      </div>

      <div class="space-y-4">
        <!-- Summary -->
        <div class="bg-gray-50 rounded-xl p-4 space-y-1 text-sm">
          <div class="flex justify-between"><span class="text-gray-500">Tổng tiền phòng</span><span class="font-semibold">{{ fmtMoney(booking.total_amount) }}</span></div>
          <div class="flex justify-between"><span class="text-gray-500">Tiền đã cọc</span><span class="text-green-600 font-semibold">{{ fmtMoney(booking.paid_amount) }}</span></div>
          <div class="flex justify-between border-t border-gray-200 pt-1 mt-1">
            <span class="text-red-600 font-semibold">Số tiền còn lại mặc định</span>
            <span class="text-red-600 font-bold">{{ fmtMoney(remainingAmount) }}</span>
          </div>
        </div>
        <div>
          <label class="label-sm">Tiền phụ thu / Dịch vụ</label>
          <div class="flex gap-2">
            <input v-model.number="additionalFee" type="number" placeholder="0" class="input-sm w-32" min="0" />
            <input v-model="additionalNote" placeholder="Ghi chú phụ thu..." class="input-sm flex-1" />
          </div>
        </div>
        <div class="bg-purple-50 rounded-xl p-4 mt-2 border border-purple-100">
          <div class="flex justify-between items-center">
            <span class="text-purple-900 font-bold">Tổng cộng số tiền cuối cùng</span>
            <span class="text-purple-700 font-bold text-lg">{{ fmtMoney(finalAmount) }}</span>
          </div>
        </div>
        <div>
          <label class="label-sm">Phương thức thanh toán</label>
          <select v-model="paymentMethod" class="input-sm w-full">
            <option value="cash">Tiền mặt</option>
            <option value="transfer">Chuyển khoản</option>
            <option value="card">Thẻ</option>
          </select>
        </div>
      </div>
      <div class="flex gap-3 mt-6">
        <button @click="$emit('close')" class="flex-1 px-4 py-2 border border-gray-200 text-gray-600 rounded-lg hover:bg-gray-50 text-sm transition-colors">Hủy</button>
        <button
          @click="submit"
          :disabled="loading || (isEarlyWarning && !earlyConfirmed)"
          class="flex-1 px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 text-sm font-medium transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {{ loading ? 'Đang xử lý...' : (isEarlyWarning ? '🚪 Xác nhận Trả sớm & Xuất hóa đơn' : 'Xác nhận Check-out & Xuất hóa đơn') }}
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
const props = defineProps<{ booking: any }>();
const emit  = defineEmits(['close','done']);
const token = () => localStorage.getItem('auth_token') || '';
const loading = ref(false);

const additionalFee  = ref(0);
const additionalNote = ref('');
const paymentMethod  = ref('cash');
// State cảnh báo trả sớm
const isEarlyWarning = ref(false);
const earlyConfirmed = ref(false);

const todayStr = new Date().toLocaleDateString('vi-VN');

function fmtDateStr(d: string) {
  if (!d) return '';
  const [y, m, day] = d.slice(0, 10).split('-');
  return `${day}/${m}/${y}`;
}

const remainingAmount = computed(() => {
  return Math.max(0, (props.booking.total_amount || 0) - (props.booking.paid_amount || 0));
});

const finalAmount = computed(() => {
  return remainingAmount.value + (additionalFee.value || 0);
});

async function submit() {
  loading.value = true;
  const res = await fetch(`/api/admin/bookings/${props.booking.id}/checkout`, {
    method:'POST',
    headers:{'Content-Type':'application/json',Authorization:`Bearer ${token()}`},
    body: JSON.stringify({
      additional_fee:  additionalFee.value,
      additional_note: additionalNote.value,
      payment_method:  paymentMethod.value,
      // Gửi kèm cờ xác nhận trả sớm nếu admin đã chấp nhận
      early_checkout:  isEarlyWarning.value && earlyConfirmed.value,
    }),
  });
  loading.value = false;

  if (res.ok) {
    const msg = isEarlyWarning.value
      ? 'Trả phòng sớm thành công. Phòng đang được dọn dẹp.'
      : 'Thanh toán thành công. Phòng đang được dọn dẹp và sẽ tự động mở lại sau 1 tiếng';
    alert(msg);
    emit('done');
    emit('close');
  } else {
    const d = await res.json();
    // Nếu backend báo là trả sớm thì hiện cảnh báo thay vì alert
    if (d.is_early) {
      isEarlyWarning.value = true;
    } else {
      alert(d.message || 'Lỗi khi check-out');
    }
  }
}
function fmtMoney(n:number){ return new Intl.NumberFormat('vi-VN').format(n??0)+'đ'; }
</script>
<style scoped>
.input-sm { border: 1px solid #e5e7eb; border-radius: 0.5rem; padding: 0.5rem 0.75rem; font-size: 0.875rem; }
.input-sm:focus { outline: none; box-shadow: 0 0 0 2px #10b981; }
.label-sm { display: block; font-size: 0.75rem; font-weight: 600; color: #6b7280; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 0.375rem; }
</style>

