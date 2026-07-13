# PES 2026 WEB — Log v1.9.3

## Quy ước đóng gói

- File ZIP mở ra là thấy ngay `app.py`, `templates`, `static`, `docs` và các file dự án.
- Không bọc toàn bộ dự án trong một thư mục cha.
- Chỉ dùng một file lịch sử thay đổi là `Log.md`.

## Thay đổi của v1.9.2

- Nâng số phiên bản hiển thị từ `V1.9.0` lên `V1.9.2`.
- Giữ các bản sửa tốc độ, đăng nhập, lỗi kết nối Supabase và giao diện quyền Admin phụ.
- Giữ các bản sửa nhập/xác nhận kết quả:
  - Ép Delta RP về số nguyên.
  - Kiểm tra thiếu dữ liệu người chơi.
  - Xác định chủ phòng bằng `host_user_id`, không mặc định `player1`.
  - Retry lỗi Supabase ngắn hạn.
  - Không để lỗi đồng bộ huy hiệu làm hỏng bước xác nhận.
  - Chống xác nhận lặp lại.
  - Tăng thông tin log trên Vercel.
- Giữ tối ưu tạo phòng, gửi lời mời và chức năng Admin sửa/lưu trận đấu.

## Nguồn tỷ lệ Tier CLB theo Rank

Ứng dụng đọc tỷ lệ theo thứ tự ưu tiên:

1. Bảng `public.system_settings` trên Supabase.
2. Dòng có `setting_key = 'rank_club_tier_weights'`.
3. Dữ liệu JSON nằm trong cột `setting_value`.
4. Nếu bảng, dòng cấu hình hoặc kết nối Supabase có lỗi, ứng dụng dùng cấu hình mặc định `RANK_CLUB_TIER_WEIGHTS` trong `app.py`.
5. Cấu hình được cache trong bộ nhớ 30 giây rồi mới đọc lại Supabase.

### Cấu hình mặc định trong app.py

```python
RANK_CLUB_TIER_WEIGHTS = {
    0: {"S+": 100},
    1: {"S+": 100},
    2: {"S+": 100},
    3: {"S+": 75, "S": 25},
    4: {"S+": 10, "S": 45, "A+": 45},
    5: {"S+": 5, "S": 20, "A+": 50, "A": 25},
    6: {"S": 5, "A+": 15, "A": 45, "B": 35},
    7: {"A+": 5, "A": 10, "B": 50, "C": 35},
    8: {"B": 10, "C": 55, "D": 35},
    9: {"B": 15, "C": 25, "D": 60},
}
```

Lưu ý: khóa `0..9` là cấp Rank nội bộ từ thấp đến cao. Khi nhập cấu hình từ giao diện/JSON, app kiểm tra Rank `1..10`, sau đó chuyển về `0..9` để sử dụng.


## Thay đổi của v1.9.3

- Tách nút **Lưu quyền** khỏi hai công tắc quyền, không còn cảm giác dính với quyền Import CSV.
- Đưa nút Lưu quyền xuống một hàng riêng, rộng toàn bộ khối quyền và tăng vùng bấm.
- Loại bỏ hiệu ứng dịch chuyển khi rê chuột khiến nút nhấp nháy.
- Thêm trạng thái `Đang lưu...` và khóa nút ngay sau lần bấm đầu tiên để tránh gửi lệnh lặp.
- Giữ nút **Gỡ quyền Admin** ở một khu vực riêng để tránh bấm nhầm.
- Không thay đổi cơ chế phân quyền hoặc dữ liệu Supabase.
