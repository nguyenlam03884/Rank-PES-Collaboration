# Fix lỗi /bxh - Errno 16 Device or resource busy

## Nguyên nhân tìm thấy
- `before_request()` gọi `ensure_admin()` trước mọi request, tạo thêm truy vấn đọc/cập nhật Supabase.
- Người đã đăng nhập bị cập nhật `is_online/last_seen_at` ở mọi request.
- `execute_query()` chưa nhận diện chuỗi `Device or resource busy` / `Errno 16` là lỗi tạm thời.
- Route `/bxh` không có fallback nên một lỗi kết nối ngắn lập tức trả HTTP 500.

## Đã sửa
- Bỏ `ensure_admin()` khỏi `before_request()`.
- Giới hạn cập nhật hoạt động tối đa 1 lần mỗi 45 giây, trừ endpoint heartbeat.
- Retry tối đa 4 lần cho ConnectError, Errno 16, timeout và lỗi mạng tạm thời.
- `/bxh` vẫn hiển thị trang nếu truy vấn người chơi hoặc lịch sử trận tạm lỗi.
- Đã chạy `python -m py_compile app.py` thành công.
