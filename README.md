## V1.10.28_ROOM_RANK_FRAME_CARD_BACKGROUND_CLEANUP_NO_SQL

**Mục tiêu:** bỏ hẳn nền xanh/đỏ phía sau 2 ô người chơi trong phòng đấu, chỉ giữ khung rank làm chủ đạo.

**Thay đổi:**
- `static/style.css` override nền `room-team-card.home` và `room-team-card.away` thành trong suốt.
- Bỏ border/box-shadow ngoài của 2 card người chơi.
- Tắt lớp overlay nền `room-team-card::after`.
- Tăng nhẹ độ nổi của ảnh khung rank để tổng thể sạch và chuyên nghiệp hơn.
- `APP_VERSION` cập nhật lên `V1.10.28`.

**Không thay đổi:**
- Không cần SQL.
- Không thay đổi database.
- Không đụng Shop, Gift Code, ZCOIN, Điểm danh, BXH, Admin hoặc logic tính điểm.

**Commit nên đặt khi upload GitHub:** `V1.10.28_ROOM_RANK_FRAME_CARD_BACKGROUND_CLEANUP_NO_SQL`


## V1.10.27_ROOM_RANK_FRAME_LAYOUT_HOTFIX_NO_SQL

**Mục tiêu:** chỉnh lại bố cục khung rank trong phòng đấu để avatar, tên người chơi, rank và phần chân khung cân đối hơn.

**Thay đổi:**
- `templates/room_detail.html` đổi avatar phòng đấu sang kích thước phù hợp hơn và đưa tên giải xuống phần chân khung.
- `static/style.css` căn lại vị trí khung rank, avatar, tên người chơi, dòng rank, logo đội, tên đội và footer giải đấu.
- `APP_VERSION` cập nhật lên `V1.10.27`.

**Không thay đổi:**
- Không cần SQL.
- Không thay đổi database.
- Không đụng Shop, Gift Code, ZCOIN, Điểm danh, BXH, Admin hoặc logic tính điểm.

**Commit nên đặt khi upload GitHub:** `V1.10.27_ROOM_RANK_FRAME_LAYOUT_HOTFIX_NO_SQL`



## V1.10.26_ROOM_RANK_FRAME_ASSETS_NO_SQL

**Mục tiêu:** thêm 10 ảnh khung rank mới vào phòng đấu, tự động hiển thị theo rank hiện tại của từng người chơi.

**Thay đổi:**
- Thêm `static/rank_frames/` gồm 10 ảnh PNG: Gà, Non, Báo Thủ, Mới Tập Chơi, Bán Chuyên, Chuyên Nghiệp, Đẳng Cấp, Siêu Sao, Huyền Thoại, GOAT.
- `templates/room_detail.html` hiển thị khung rank phía sau card chủ phòng và khách.
- `static/style.css` bổ sung CSS đặt khung rank như lớp trang trí, không ảnh hưởng logic phòng đấu.
- `APP_VERSION` cập nhật lên `V1.10.26`.

**Không thay đổi:**
- Không cần SQL.
- Không thay đổi database.
- Không đụng Shop, Gift Code, ZCOIN, Điểm danh, BXH, Admin hoặc logic tính điểm.

**Commit nên đặt khi upload GitHub:** `V1.10.26_ROOM_RANK_FRAME_ASSETS_NO_SQL`


## V1.10.25_SHOP_TAB_PAGE_NAVIGATION_NO_SQL

**Mục tiêu:** chỉnh Cửa Hàng thành dạng tab/danh mục riêng, không còn dùng anchor nhảy xuống section bên dưới.

**Thay đổi:**
- `/shop` nhận tham số `?tab=` để mở đúng danh mục: Nổi bật, Trang trí, Tiện ích, Lucky Box, Gift Code.
- Chỉ hiển thị nội dung của tab đang chọn.
- Gift Code chuyển thành tab riêng trong Cửa Hàng.
- Menu user trỏ Gift Code tới `/shop?tab=gift-code`.
- Cập nhật CSS active tab và khu nội dung tab.

**Không thay đổi:**
- Không cần SQL.
- Không thay đổi database.
- Không đụng Gift Code backend, ZCOIN, Điểm danh, phòng đấu, BXH hoặc Admin.

**Commit nên đặt khi upload GitHub:** `V1.10.25_SHOP_TAB_PAGE_NAVIGATION_NO_SQL`



## V1.10.24_SHOP_TEMPLATE_ITEMS_HOTFIX_NO_SQL

**Mục tiêu:** sửa lỗi 500 khi người dùng click vào Cửa Hàng sau bản V1.10.23.

**Nguyên nhân:** trong `templates/shop.html`, biến `section.items` bị Jinja hiểu là method `.items()` của dictionary, không phải danh sách item khung, dẫn đến lỗi `TypeError: 'builtin_function_or_method' object is not iterable`.

**Thay đổi:**
- Sửa `templates/shop.html` để dùng cú pháp key rõ ràng: `section['items']`.
- Cập nhật các key liên quan trong Shop: `key`, `icon`, `title`, `subtitle`.
- Cập nhật `APP_VERSION` lên `V1.10.24`.

**Không thay đổi:**
- Không cần SQL.
- Không thay đổi database.
- Không đụng Gift Code backend, ZCOIN, Điểm danh, BXH, phòng đấu, Admin sửa kết quả hoặc bật/tắt giao hữu.

**Commit nên đặt khi upload GitHub:** `V1.10.24_SHOP_TEMPLATE_ITEMS_HOTFIX_NO_SQL`

## V1.10.23_SHOP_SHELL_GIFT_CODE_SAFE

**Mục tiêu:** mở khung Cửa Hàng/Kho đồ trước và thêm Gift Code thật để Admin tặng ZCOIN cho người chơi.

**Thay đổi:**
- Thêm trang `/shop` dạng khung: Nổi bật, Trang trí, Tiện ích, Lucky Box.
- Thêm trang `/inventory` dạng khung Kho đồ, chưa có vật phẩm thật.
- Thêm lối vào Cửa Hàng ở sidebar và Kho đồ/Gift Code trong menu user.
- Thêm Gift Code: người dùng nhập mã trong Cửa Hàng để nhận ZCOIN.
- Thêm tab Admin `Gift Code` để tạo/tắt code và xem lịch sử đổi code.

**SQL:** cần chạy `docs/01_install_v1_10_23_shop_shell_gift_code.sql`, sau đó kiểm tra bằng `docs/02_check_v1_10_23_shop_shell_gift_code.sql`.

**Không thay đổi:**
- Không đụng logic rank, phòng đấu, BXH, random đội.
- Không đổi Điểm danh hằng ngày; Gift Code chỉ dùng chung ví ZCOIN.

**Commit nên đặt khi upload GitHub:** `V1.10.23_SHOP_SHELL_GIFT_CODE_SAFE`


## V1.10.22_ADMIN_MATCH_RESULT_DELTA_HOTFIX_NO_SQL

**Mục tiêu:** sửa lỗi Admin không lưu được kết quả trận đấu do `matches.delta1`/`delta2` bị ghi `NULL` trong khi database đang yêu cầu NOT NULL.

**Thay đổi:**
- Admin sửa kết quả dùng `delta1 = 0`, `delta2 = 0` làm giá trị tạm trước khi tính lại RP.
- Sau khi chuẩn bị tỷ số mới, hệ thống vẫn gọi `apply_match_result()` để tính delta thật và cập nhật BXH.
- Luồng xử lý tranh chấp Admin cũng được chỉnh để không chuyển thẳng sang confirmed trước khi tính RP.
- Rollback nội bộ khi sửa lỗi luôn restore delta thành số nguyên an toàn, không ghi NULL.

**Không thay đổi:**
- Không cần SQL/database migration.
- Không đổi công thức tính RP.
- Không đụng ZCOIN, Điểm danh, BXH, Dashboard, Players, menu user hoặc Kho đồ.

**Commit nên đặt khi upload GitHub:** `V1.10.22_ADMIN_MATCH_RESULT_DELTA_HOTFIX_NO_SQL`


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


## V1.10.20_TOPBAR_ZCOIN_BALANCE_NO_SQL

**Mục tiêu:** hiển thị số dư ZCOIN ngay trên thanh topbar cạnh khu thông báo, để người chơi nhìn thấy số dư ở mọi trang.

**Thay đổi:**
- Thêm pill ZCOIN trên topbar.
- Pill ZCOIN trỏ về `Hồ sơ cá nhân → ZCOIN`.
- Cập nhật CSS responsive cho desktop/mobile.

**Không thay đổi:**
- Không đụng SQL/database.
- Không đụng logic điểm danh.
- Không đụng phòng đấu, BXH, lịch sử, Players, Admin.

**Commit nên đặt khi upload GitHub:** `V1.10.20_TOPBAR_ZCOIN_BALANCE_NO_SQL`


## V1.10.21_TOPBAR_ZCOIN_LOGO_NO_SQL

**Mục tiêu:** thay icon ZCOIN dạng emoji trên topbar bằng logo ZCOIN riêng do dự án cung cấp.

**Thay đổi:**
- Thêm asset `static/zcoin-logo.png`.
- Topbar ZCOIN sử dụng logo mới thay cho icon emoji.
- CSS tối ưu kích thước logo trong desktop/mobile.

**Không thay đổi:**
- Không đụng SQL/database.
- Không đụng logic điểm danh/ZCOIN.
- Không đụng phòng đấu, BXH, lịch sử, Players, Admin.

**Commit nên đặt khi upload GitHub:** `V1.10.21_TOPBAR_ZCOIN_LOGO_NO_SQL`
