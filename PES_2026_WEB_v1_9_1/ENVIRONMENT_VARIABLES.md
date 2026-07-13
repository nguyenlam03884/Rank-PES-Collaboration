# Environment Variables

Bản Collaboration sử dụng cùng tên biến chính với bản Production v1.9.0:

- `SUPABASE_URL`
- `SUPABASE_SERVICE_ROLE_KEY`
- `FLASK_SECRET_KEY`

`APP_ENV` là tùy chọn. `SUPABASE_ANON_KEY` hiện không được backend Flask sử dụng.

Để tương thích, code cũng chấp nhận `SUPABASE_KEY` thay cho `SUPABASE_SERVICE_ROLE_KEY` và `SECRET_KEY` thay cho `FLASK_SECRET_KEY`, nhưng nên giữ đúng ba tên chính phía trên.
