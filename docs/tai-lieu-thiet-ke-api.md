    # BIỂU MẪU 01

    ## TÀI LIỆU THIẾT KẾ API

    | Tên dự án | Module | Phiên bản |
    | :--- | :--- | :--- |
    | Homestay Booking | Toàn bộ hệ thống | 1.0 |

    ### DANH SÁCH API ENDPOINTS

    | # | Phương thức | Đường dẫn (URL) | Mô tả | Request Body | Response | Mã trạng thái |
    | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
    | **I** | **ROOMS (PUBLIC)** | | | | | |
    | 1 | GET | `/api/rooms` | Lấy danh sách phòng | - | `[{ id, title, price, image... }]` | 200 |
    | 2 | GET | `/api/rooms/{id}` | Lấy chi tiết 1 phòng | - | `{ id, title, images[], amenity_list[]... }` | 200, 404 |
    | **II** | **AUTHENTICATION & PROFILE** | | | | | |
    | 3 | POST | `/api/register` | Đăng ký tài khoản | `{ name, email, password, password_confirmation }` | `{ user, token, message }` | 201, 400 |
    | 4 | POST | `/api/login` | Đăng nhập hệ thống | `{ email, password }` | `{ user, token, message }` | 200, 401 |
    | 5 | POST | `/api/profile/update` | Cập nhật hồ sơ user | `{ name, phone, address... }` | `{ user, message }` | 200, 400 |
    | 6 | POST | `/api/check-status` | Kiểm tra trạng thái tài khoản | - | `{ status: "active/inactive" }` | 200 |
    | 7 | GET | `/api/user` | Lấy thông tin user hiện tại | - | `{ id, name, email, role... }` | 200, 401 |
    | **III** | **TIỆN NGHI (AMENITIES)** | | | | | |
    | 8 | GET | `/api/amenities` | Lấy danh sách tiện nghi | - | `[{ id, name, icon_class... }]` | 200 |
    | 9 | POST | `/api/amenities` | Tạo tiện nghi mới | `{ name, icon_class }` | `{ amenity: {...} }` | 201, 400 |
    | 10 | DELETE | `/api/amenities/{id}` | Xóa tiện nghi | - | `{ message: "Success" }` | 200, 404 |
    | **IV** | **ĐẶT PHÒNG KHÁCH HÀNG & INVOICE** | | | | | |
    | 11 | POST | `/api/bookings` | Khách tạo đặt phòng | `{ room_id, customer_name, customer_phone, customer_email, start_date, end_date... }` | `{ booking: {...}, message }` | 201, 400 |
    | 12 | GET | `/api/admin/invoices` | Lấy danh sách hóa đơn | - | `[{ id, user_id, amount, status... }]` | 200 |
    | 13 | PUT | `/api/admin/invoices/{id}/checkout`| Thanh toán hóa đơn | `{ payment_method, amount... }` | `{ message: "Success" }` | 200, 400 |
    | 14 | DELETE | `/api/admin/invoices/{id}` | Xóa hóa đơn | - | `{ message: "Success" }` | 200, 404 |
    | **V** | **QUẢN LÝ NGƯỜI DÙNG (ADMIN)** | | | | | |
    | 15 | GET | `/api/admin/users` | Lấy danh sách người dùng | - | `{ data: [{ id, name, email... }] }` | 200 |
    | 16 | POST | `/api/admin/users` | Tạo người dùng mới | `{ name, email, role, password... }` | `{ user: {...}, message }` | 201, 400 |
    | 17 | PUT | `/api/admin/users/{id}` | Cập nhật thông tin user | `{ name, role... }` | `{ user: {...}, message }` | 200, 400 |
    | 18 | DELETE | `/api/admin/users/{id}` | Xóa người dùng | - | `{ message: "Success" }` | 200, 404 |
    | 19 | PUT | `/api/admin/users/{id}/status` | Đổi trạng thái user | `{ status }` | `{ message: "Success" }` | 200 |
    | **VI** | **QUẢN LÝ PHÒNG & TRẠNG THÁI (ADMIN)** | | | | | |
    | 20 | POST | `/api/admin/rooms` | Tạo phòng mới | `{ title, type, price, parent_id... }` | `{ room: {...} }` | 201, 400 |
    | 21 | PUT | `/api/admin/rooms/{id}` | Cập nhật thông tin phòng | `{ title, type, price... }` | `{ room: {...} }` | 200, 400 |
    | 22 | DELETE | `/api/admin/rooms/{id}` | Xóa phòng | - | `{ message: "Success" }` | 200, 404 |
    | 23 | GET | `/api/admin/rooms/stats` | Thống kê số lượng phòng | - | `{ total, active, maintenance...}`| 200 |
    | 24 | GET | `/api/admin/rooms/available` | Xem các phòng trống | `?start_date&end_date` | `[{ room: {...} }]` | 200 |
    | 25 | GET | `/api/admin/rooms/all-status`| Xem trạng thái tất cả phòng| - | `[{ id, title, status... }]` | 200 |
    | 26 | GET | `/api/admin/rooms/homestays` | Lấy danh sách homestay | - | `[{ id, title, type="entire_home"... }]`| 200 |
    | 27 | GET | `/api/admin/rooms` | Lấy ds phòng (phân cấp) | - | `[{ id, parent_id, children[]... }]`| 200 |
    | 28 | PATCH | `/api/admin/rooms/{id}/status` | Đổi trạng thái phòng | `{ status }` | `{ message: "Success" }` | 200, 400 |
    | 29 | PATCH | `/api/admin/rooms/{id}/toggle-maintenance`| Bật/tắt bảo trì phòng | - | `{ message: "Success" }` | 200 |
    | 30 | POST | `/api/admin/rooms/{id}/convert-to-room-based`| Đổi thành mô hình phòng | - | `{ message: "Converted" }` | 200, 400 |
    | **VII**| **QUẢN LÝ ĐẶT PHÒNG (ADMIN)** | | | | | |
    | 31 | GET | `/api/admin/bookings/stats` | Thống kê đặt phòng | - | `{ total_bookings, revenue, pending... }` | 200 |
    | 32 | GET | `/api/admin/bookings/calendar`| Lịch đặt phòng | `?month, year` | `[{ date, events[{ title, start, end... }] }]` | 200 |
    | 33 | GET | `/api/admin/bookings` | Danh sách đặt phòng | `?status&search...` | `{ data: [{ id, customer_name... }] }` | 200 |
    | 34 | POST | `/api/admin/bookings` | Tạo đặt phòng (Admin xử lý) | `{ room_id, customer_name, start_date, end_date... }` | `{ booking: {...}, message }` | 201, 400 |
    | 35 | GET | `/api/admin/bookings/{id}` | Chi tiết 1 đặt phòng | - | `{ id, customer, room, payments[], services[]... }` | 200, 404 |
    | 36 | PUT | `/api/admin/bookings/{id}` | Cập nhật đặt phòng | `{ customer_name, note... }` | `{ booking: {...}, message }` | 200, 400 |
    | 37 | PATCH | `/api/admin/bookings/{id}/status`| Đổi trạng thái đặt phòng | `{ status }` | `{ message: "Success" }` | 200, 400 |
    | 38 | POST | `/api/admin/bookings/{id}/checkin`| Check-in khách vào phòng | - | `{ message: "Success" }` | 200, 400 |
    | 39 | POST | `/api/admin/bookings/{id}/checkout`| Check-out & thanh toán | `{ payment_info... }` | `{ message: "Success" }` | 200, 400 |
    | 40 | POST | `/api/admin/bookings/{id}/cancel` | Hủy đặt phòng | `{ reason }` | `{ message: "Success" }` | 200, 400 |
    | 41 | POST | `/api/admin/bookings/{id}/transfer-room`| Chuyển khách sang phòng khác| `{ new_room_id }` | `{ message: "Success" }` | 200, 400 |
    | **VIII**| **DỊCH VỤ & THANH TOÁN (ADMIN)** | | | | | |
    | 42 | POST | `/api/admin/bookings/{id}/services`| Thêm dịch vụ cho booking | `{ service_name, price, quantity... }`| `{ message: "Success" }` | 201, 400 |
    | 43 | DELETE | `/api/admin/bookings/{id}/services/{sid}`| Xóa dịch vụ khỏi booking | - | `{ message: "Success" }` | 200, 404 |
    | 44 | GET | `/api/admin/bookings/{id}/payments`| Xem các lần thanh toán | - | `[{ id, amount, payment_method... }]` | 200 |
    | 45 | POST | `/api/admin/bookings/{id}/payments`| Thêm giao dịch thanh toán | `{ amount, payment_method, note }` | `{ message: "Success", payment: {...} }` | 201, 400 |
