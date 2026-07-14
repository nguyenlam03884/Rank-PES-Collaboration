
## Update V1.10.19_FRIENDLY_TOGGLE_HARD_LOCK_NO_SQL

Mục tiêu: sửa dứt điểm tình trạng Admin tắt Giao hữu nhưng người chơi vẫn còn thấy hoặc bấm được chức năng Giao hữu trong phòng đấu.

Thay đổi chính:

- Admin / Hệ thống / Trận giao hữu dùng 2 nút rõ ràng: `Bật giao hữu` và `Tắt giao hữu`, tránh hiểu nhầm trạng thái công tắc.
- Trang phòng đấu đọc trạng thái Giao hữu mới nhất từ database khi render, hạn chế cache trạng thái cũ.
- Backend vẫn chặn request quay Giao hữu nếu Admin đã tắt, kể cả khi user còn tab cũ/cache.
- Nếu đang có trận Giao hữu cũ, chỉ cho kết thúc trận; không cho tự random tiếp khi hệ thống đã tắt Giao hữu.

SQL: không cần.
Rollback: rollback Vercel về bản trước, không cần restore Supabase.

# PES 2026 / Rank-PES-Collaboration

Đây là mốc phát triển chung của dự án PES 2026. Khi cập nhật source, luôn ghi rõ version, phạm vi thay đổi và có/không cần SQL để tránh người này update đè mất phần của người kia.

## Quy tắc update an toàn

1. Mỗi bản update phải có tên version rõ ràng, ví dụ: `V1.10.17_ROOM_CONFIRM_UI_HOTFIX_NO_SQL`.
2. Chỉ upload đúng file cần thay đổi, không upload nguyên thư mục source lồng nhau.
3. Không đưa các file sau lên GitHub hoặc ZIP update: `.env`, `__pycache__`, `*.pyc`, service role key, mật khẩu/API key thật.
4. Nếu bản update cần SQL, phải tách riêng trong `docs/` gồm file install, check và rollback khi cần.
5. Trước khi deploy bản có SQL hoặc chỉnh logic quan trọng, cần backup/ghi nhớ deployment ổn định hiện tại trên Vercel.
6. Nếu lỗi giao diện/code, rollback Vercel về deployment trước. Nếu lỗi liên quan database mới cân nhắc SQL rollback.

## Mốc version gần nhất

### V1.10.17_ROOM_CONFIRM_UI_HOTFIX_NO_SQL

- Sửa lỗi giao diện phòng đấu khi trận đang chờ xác nhận kết quả.
- Tỷ số đã nhập như `1 - 0` được hiển thị lớn, căn giữa, không bị dính vào nút xác nhận/tranh chấp.
- Không thay đổi database.
- Không cần SQL.
- File chính thay đổi: `static/style.css`, `app.py`, `Log.md`, `README.md`, `docs/update_v1_10_17_room_confirm_ui_hotfix_no_sql.txt`.

### V1.10.16_ROOM_SCORE_FRIENDLY_TOGGLE_NO_SQL

- Khôi phục tỷ số `0 - 0` ở giữa phòng đấu khi trận đang thi đấu.
- Thêm công tắc Admin bật/tắt trận giao hữu.
- Không cần SQL.

### V1.10.15_MERGE_LEAGUE_LOGOS_DAILY_CHECKIN_SAFE

- Gộp logo giải đấu trong phòng đấu với hệ thống ZCOIN/Điểm danh.
- Giữ điểm danh hằng ngày 80–150 ZCOIN, popup nhận thưởng và confetti.

### V1.10.14_PROFILE_DAILY_CHECKIN_SAFE

- Thêm ZCOIN thật và Điểm danh hằng ngày trong Hồ sơ cá nhân.
- Có SQL install/check/rollback trong `docs/`.

## Update V1.10.18_ROOM_SCORE_INPUT_LEAGUE_LOGO_HOTFIX_NO_SQL

- Mục tiêu: hotfix nhỏ cho phòng đấu, không thay đổi database.
- Làm chữ khu nhập kết quả trận đấu lớn hơn, đậm hơn, input dễ thao tác hơn.
- Bổ sung cơ chế fallback logo giải đấu, ưu tiên sửa các biến thể Ligue 1 và các tên giải dễ lệch định dạng.
- Thêm fallback khi logo đội/giải bị lỗi URL để không hiện icon ảnh lỗi.
- Không đụng ZCOIN, Điểm danh, BXH, Dashboard, Players, logic random đội hoặc tính điểm RP.
- Không cần SQL. Rollback: quay lại deployment V1.10.17 trên Vercel nếu cần.

### Quy tắc phối hợp update

- Mỗi bản update phải có version rõ ràng.
- Ghi chú thay đổi vào README.md, Log.md và docs/.
- Chỉ sửa đúng phạm vi tính năng cần sửa.
- Không upload .env, __pycache__, *.pyc.
- Nếu có SQL phải tách install/check/rollback và chỉ chạy khi đã thống nhất.
