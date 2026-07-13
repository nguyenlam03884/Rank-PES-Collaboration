# V1.9.1 Speed Edition

## Mục tiêu
Giảm độ trễ khi mở trang, chuyển trang và khi nhiều tab/người dùng cùng hoạt động trên Vercel + Supabase.

## Thay đổi
- Không chặn render HTML để chờ dữ liệu phụ: lời mời, phòng đang hoạt động và thông báo hệ thống được tải bằng API sau khi giao diện đã hiện.
- Thêm cache RAM TTL rất ngắn trên warm instance:
  - Người dùng hiện tại: 8 giây.
  - Danh sách người chơi/BXH: 8 giây.
  - Phòng và lời mời: 3 giây.
  - Thành tích: 30 giây.
  - Thông báo hệ thống: 15 giây.
- Cache chỉ gộp truy vấn lặp, Supabase vẫn là nguồn dữ liệu chính.
- Không gọi lặp danh sách lời mời hai lần trong cùng request.
- Giảm polling nền khi tab không được mở.
- Giãn các polling không khẩn cấp như chat sảnh, số người online và thông báo hệ thống.
- Giữ kiểm tra trạng thái phòng trực tiếp ở mức nhanh 4 giây.

## Không thay đổi
- Công thức Rank Point.
- Dữ liệu Supabase.
- Cơ chế đăng nhập.
- Quyền Admin và Admin phụ.
- Luồng phòng đấu, xác nhận kết quả và xử phạt.
