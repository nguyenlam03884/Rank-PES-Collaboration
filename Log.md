
## V1.10.19_FRIENDLY_TOGGLE_HARD_LOCK_NO_SQL

- Sửa triệt để nút bật/tắt trận Giao hữu trong Admin.
- Đổi giao diện Admin từ công tắc dễ hiểu nhầm sang 2 nút rõ ràng: Bật giao hữu / Tắt giao hữu.
- Room detail luôn đọc trạng thái Giao hữu mới nhất từ database, tránh cache làm user vẫn thấy card Giao hữu sau khi Admin tắt.
- Backend tiếp tục hard-block request quay đội Giao hữu khi Admin đã tắt.
- Khi Giao hữu đang tắt, card Giao hữu trong phòng đấu hiển thị trạng thái khóa; trận Giao hữu cũ chỉ còn cho kết thúc, không cho random tiếp.
- Không cần SQL, không đổi logic Rank/ZCOIN/Điểm danh/BXH.
- File thay đổi: app.py, templates/admin.html, templates/room_detail.html, static/style.css, README.md, Log.md, docs/update_v1_10_19_friendly_toggle_hard_lock_no_sql.txt.

# Log

## V1.10.17_ROOM_CONFIRM_UI_HOTFIX_NO_SQL

- Hotfix giao diện phòng đấu khi trạng thái đang chờ xác nhận kết quả.
- Sửa lỗi tỷ số đã nhập như `1 - 0` bị hiển thị nhỏ, lệch và dính vào hai nút `Xác Nhận` / `Không Đồng Ý`.
- Khôi phục layout tỷ số lớn ở giữa phòng đấu, hai nút xác nhận/tranh chấp nằm cùng hàng, cân đối như giao diện trước.
- Không thay đổi logic xác nhận kết quả, không thay đổi tính điểm, không đổi database.
- Không cần SQL.
- File thay đổi: `app.py`, `static/style.css`, `Log.md`, `README.md`, `docs/update_v1_10_17_room_confirm_ui_hotfix_no_sql.txt`.
- Rollback: quay lại deployment/commit V1.10.16 trên Vercel/GitHub, không cần restore Supabase.

## V1.10.14

- Cập nhật trực tiếp trên bản người dùng gửi `V1.10.13`.
- Chỉ sử dụng 11 logo league do người dùng cung cấp, không dùng lại logo tự tạo trước đó.
- Chuẩn hoá tất cả logo thành PNG 128x128, giữ đúng tỉ lệ, căn giữa và làm trong suốt phần nền ngoài khi có thể.
- Hiển thị logo nhỏ 22x22 cạnh tên giải trong phòng đấu, phù hợp vì logo giải chỉ là thông tin phụ.
- Thêm mapping Supabase cho Africa, Bundesliga, Europe, LaLiga EA Sports, Süper Lig, Serie BKT, Sky Bet Championship, South America, Serie A, Premier League và Ligue 1.
- Không cần SQL.


## V1.10.13_USER_DROPDOWN_LOGOUT_ONLY_NO_SQL

- Chuyển Đăng xuất vào menu xổ xuống của tên người dùng.
- Gỡ nút Đăng xuất riêng khỏi sidebar để sidebar gọn hơn.
- Không thay đổi database.
- Không cần SQL.
- File thay đổi: app.py, templates/base.html, static/style.css, Log.md, docs/update_v1_10_13_user_dropdown_logout_only_no_sql.txt.
- Rollback: quay lại deployment/commit trước, không cần restore database.

# Log

## V1.10.8

- Thay file `static/xucxac.png` bằng đúng ảnh xúc xắc mới người dùng cung cấp.
- Thêm tham số phiên bản vào URL ảnh để trình duyệt không dùng ảnh lỗi đã cache.
- Giữ xúc xắc đầy đủ màu sắc ở cả giao diện chủ phòng và đội khách.
- Đội khách hiển thị chữ `ĐỢI QUAY RANDOM ĐỘI`.
- Chủ phòng chưa thể quay vì khách chưa sẵn sàng sẽ thấy `ĐỢI KHÁCH SẴN SÀNG`.
- Chủ phòng đủ điều kiện vẫn thấy `QUAY RANDOM ĐỘI` và có thể bấm để quay.
- Cập nhật phiên bản thành `V1.10.8`.

## V1.10.10_PROFILE_UI_REORGANIZE_REPACK_NO_SQL

- Đóng gói lại bản tối ưu giao diện Hồ sơ cá nhân theo dạng root-only, tránh upload nhầm cả thư mục source lồng nhau.
- Sắp xếp lại Hồ sơ cá nhân thành các tab: Tổng quan, Thành tích, Lịch sử, ZCOIN, Điểm danh, Tài khoản.
- Tab ZCOIN và Điểm danh chỉ là khung giao diện, chưa kết nối database thật.
- Không cần SQL.
- Không thay đổi database.
- Cập nhật APP_VERSION thành V1.10.10 để dễ kiểm tra deploy.
- File thay đổi: app.py, templates/profile.html, static/style.css, Log.md, docs/update_v1_10_10_profile_ui_repack_no_sql.txt.
- Rollback: quay lại deployment/commit trước, không cần restore database.

## V1.10.11_PROFILE_TABS_FORCE_NO_SQL

- Repack riêng phần Hồ sơ cá nhân để bắt buộc cập nhật giao diện tab mới lên Production.
- Chỉ tác động khu vực hồ sơ: `templates/profile.html` và CSS hồ sơ trong `static/style.css`.
- `app.py` chỉ đổi `APP_VERSION` từ V1.10.10 sang V1.10.11 để dễ xác nhận deploy.
- Thêm tab: Tổng quan, Thành tích, Lịch sử, ZCOIN, Điểm danh, Tài khoản.
- Tab ZCOIN và Điểm danh chỉ là khung giao diện, chưa kết nối database thật.
- Không cần SQL.
- Không thay đổi database.
- Rollback: quay lại deployment/commit V1.10.10 trên Vercel/GitHub, không cần restore Supabase.


## V1.10.12_USER_DROPDOWN_MENU_NO_SQL

- Gom lối vào Hồ sơ cá nhân và Lịch sử khỏi sidebar vào menu xổ xuống ở tên người dùng trên topbar.
- Menu người dùng mới gồm: Quản lý tài khoản, Kho đồ (khung sắp phát triển), Điểm danh (khung trong hồ sơ), Lịch sử, Đăng xuất.
- Không thay đổi database, không thêm route mới, không sửa logic thi đấu/rank/phòng đấu.
- Chỉ cập nhật giao diện điều hướng và APP_VERSION.

## V1.10.15_MERGE_LEAGUE_LOGOS_DAILY_CHECKIN_SAFE

- Gộp bản update mới của bạn bạn với hệ thống Điểm danh/ZCOIN đã chạy thành công.
- Giữ phần logo giải đấu trong phòng đấu từ bản bạn bạn gửi.
- Giữ ví ZCOIN, điểm danh hằng ngày 80–150 ZCOIN, popup nhận thưởng và confetti.
- Nếu đã chạy SQL V1.10.14 và điểm danh hoạt động thì không cần chạy SQL thêm.
- File thay đổi: app.py, templates/base.html, templates/profile.html, templates/room_detail.html, static/style.css, Log.md, docs/*.
- Rollback: quay lại deployment trước; không cần restore database nếu chỉ lỗi code.
## V1.10.16_ROOM_SCORE_FRIENDLY_TOGGLE_NO_SQL

- Khôi phục hiển thị tỷ số 0 - 0 ở giữa phòng đấu khi trận đang thi đấu.
- Thêm cài đặt Admin bật/tắt chế độ trận giao hữu trong tab Hệ thống.
- Khi giao hữu bị tắt, phòng đấu chỉ cho quay trận Xếp hạng và không cho random tiếp giao hữu.
- Không cần SQL, không đổi database schema.


## V1.10.18_ROOM_SCORE_INPUT_LEAGUE_LOGO_HOTFIX_NO_SQL

- Tăng độ rõ của khu nhập kết quả trong phòng đấu: tiêu đề, label, input và nút gửi kết quả to/đậm hơn.
- Bổ sung alias/fallback logo giải đấu, đặc biệt cho Ligue 1 và các tên giải có biến thể dấu/khoảng trắng/gạch nối.
- Thêm fallback khi ảnh đội hoặc ảnh giải bị lỗi URL, tránh hiển thị icon ảnh lỗi.
- Không cần SQL.
- File thay đổi: app.py, templates/room_detail.html, static/style.css, README.md, Log.md, docs/update_v1_10_18_room_score_input_league_logo_hotfix_no_sql.txt.


## V1.10.20_TOPBAR_ZCOIN_BALANCE_NO_SQL

- Hiển thị số dư ZCOIN của người dùng ngay trên topbar, cạnh khu thông báo/chuông.
- Pill ZCOIN dẫn nhanh về Hồ sơ cá nhân → tab ZCOIN.
- Không thay đổi database, điểm danh, phòng đấu, BXH, admin hoặc logic tính điểm.
- Không cần SQL.
- Commit khuyến nghị trên GitHub: `V1.10.20_TOPBAR_ZCOIN_BALANCE_NO_SQL`.
