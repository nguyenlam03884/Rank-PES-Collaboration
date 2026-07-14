# Log

## V1.10.8

- Thay file `static/xucxac.png` bằng đúng ảnh xúc xắc mới người dùng cung cấp.
- Thêm tham số phiên bản vào URL ảnh để trình duyệt không dùng ảnh lỗi đã cache.
- Giữ xúc xắc đầy đủ màu sắc ở cả giao diện chủ phòng và đội khách.
- Đội khách hiển thị chữ `ĐỢI QUAY RANDOM ĐỘI`.
- Chủ phòng chưa thể quay vì khách chưa sẵn sàng sẽ thấy `ĐỢI KHÁCH SẴN SÀNG`.
- Chủ phòng đủ điều kiện vẫn thấy `QUAY RANDOM ĐỘI` và có thể bấm để quay.
- Cập nhật phiên bản thành `V1.10.8`.

## V1.10.9_PROFILE_UI_REORGANIZE_NO_SQL

- Tối ưu lại giao diện Hồ sơ cá nhân theo dạng tab thông minh.
- Thêm các tab: Tổng quan, Thành tích, Lịch sử, ZCOIN, Điểm danh, Tài khoản.
- Tab ZCOIN và Điểm danh chỉ là khung sườn giao diện, chưa kết nối database thật.
- Không cần SQL.
- Không thay đổi database.
- File thay đổi: app.py, templates/profile.html, static/style.css, Log.md, docs/update_v1_10_9_profile_ui_reorganize_no_sql.txt.
- Rollback: quay lại commit/deployment trước, không cần restore database.

