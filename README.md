## V1.10.40_ROOM_SCORE_ORDER_RP_FIX_NO_SQL

### Nội dung sửa

- Sửa lỗi xác nhận kết quả báo: `Sai quy tắc RP: người thắng phải được cộng và người thua phải bị trừ điểm.`
- Đồng bộ đúng thứ tự điểm số giữa `host/guest` trong phòng và `player1/player2` trong bảng trận đấu.
- Tự sửa trận đang chờ xác nhận nếu thứ tự hai người chơi trong match bị đảo.
- Người thắng được cộng RP, người thua bị trừ RP theo đúng quy tắc hiện tại.
- Thông báo sau xác nhận hiển thị đúng RP của Chủ phòng và Khách.
- Không thay đổi dữ liệu lịch sử đã xác nhận và không thay đổi chức năng ngoài phạm vi sửa lỗi.

### Phiên bản

- `APP_VERSION = V1.10.40`

### SQL

- **Không cần chạy SQL.**

### Upload GitHub

Không upload `.env`, `__pycache__/` hoặc `*.pyc`.
