<template>
  <div class="fixed inset-0 bg-black/60 z-[60] flex items-center justify-center p-4" @click.self="$emit('close')">
    <div class="bg-white rounded-2xl shadow-2xl w-full max-w-md p-6">
      <h3 class="text-lg font-bold text-gray-800 mb-4">🚪 Xác nhận Check-out</h3>
      <div class="space-y-4">
        <!-- Summary -->
        <div class="bg-gray-50 rounded-xl p-4 space-y-1 text-sm">
          <div class="flex justify-between"><span class="text-gray-500">Tổng hóa đơn</span><span class="font-semibold">{{ fmtMoney(booking.total_amount) }}</span></div>
          <div class="flex justify-between"><span class="text-gray-500">Đã thanh toán</span><span class="text-green-600 font-semibold">{{ fmtMoney(booking.paid_amount) }}</span></div>
          <div v-if="booking.remaining_amount > 0" class="flex justify-between border-t border-gray-200 pt-1 mt-1">
            <span class="text-red-600 font-semibold">Còn phải thu</span>
            <span class="text-red-600 font-bold">{{ fmtMoney(booking.remaining_amount) }}</span>
          </div>
        </div>
        <div>
          <label class="label-sm">Phụ phí phát sinh (nếu có)</label>
          <div class="flex gap-2">
            <input v-model="extraNote" placeholder="Mô tả phí..." class="input-sm flex-1" />
            <input v-model.number="extraAmount" type="number" placeholder="0" class="input-sm w-28" min="0" />
          </div>
        </div>
        <div>
          <label class="label-sm">Thu tiền còn lại</label>
          <div class="flex gap-2">
            <input v-model.number="paymentAmount" type="number" class="input-sm flex-1" :placeholder="`${booking.remaining_amount ?? 0}`" />
            <select v-model="paymentMethod" class="input-sm w-32">
              <option value="cash">Tiền mặt</option>
              <option value="transfer">Chuyển khoản</option>
              <option value="card">Thẻ</option>
            </select>
          </div>
        </div>
      </div>
      <div class="flex gap-3 mt-6">
        <button @click="$emit('close')" class="flex-1 px-4 py-2 border border-gray-200 text-gray-600 rounded-lg hover:bg-gray-50 text-sm transition-colors">Hủy</button>
        <button @click="submit" :disabled="loading" class="flex-1 px-4 py-2 bg-purple-600 text-white rounded-lg hover:bg-purple-700 text-sm font-medium transition-colors disabled:opacity-50">
          {{ loading ? 'Đang xử lý...' : '🚪 Hoàn tất Check-out' }}
        </button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
const props = defineProps<{ booking: any }>();
const emit  = defineEmits(['close','done']);
const token = () => localStorage.getItem('auth_token') || '';
const loading = ref(false);
const extraAmount   = ref(0);
const extraNote     = ref('');
const paymentAmount = ref(props.booking.remaining_amount ?? 0);
const paymentMethod = ref('cash');
async function submit() {
  loading.value = true;
  const res = await fetch(`/api/admin/bookings/${props.booking.id}/checkout`, {
    method:'POST', headers:{'Content-Type':'application/json',Authorization:`Bearer ${token()}`},
    body: JSON.stringify({ extra_amount:extraAmount.value, extra_note:extraNote.value, payment_amount:paymentAmount.value, payment_method:paymentMethod.value }),
  });
  loading.value = false;
  if (res.ok) { emit('done'); emit('close'); }
  else { const d = await res.json(); alert(d.message||'Lỗi'); }
}
function fmtMoney(n:number){ return new Intl.NumberFormat('vi-VN').format(n??0)+'đ'; }
</script>
<style scoped>
.input-sm { border: 1px solid #e5e7eb; border-radius: 0.5rem; padding: 0.5rem 0.75rem; font-size: 0.875rem; }
.input-sm:focus { outline: none; box-shadow: 0 0 0 2px #10b981; }
.label-sm { display: block; font-size: 0.75rem; font-weight: 600; color: #6b7280; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 0.375rem; }
</style>
