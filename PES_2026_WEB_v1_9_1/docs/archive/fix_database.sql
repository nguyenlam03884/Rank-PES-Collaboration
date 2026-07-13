-- PES eFootball 2026 V1.6.4 - sửa dữ liệu khóa ngoại bị lệch
-- Chạy một lần trong Supabase > SQL Editor trước khi deploy bản mới.

begin;

-- Các thông báo cũ có admin_user_id không còn tồn tại sẽ chuyển về NULL.
update public.admin_announcements a
set admin_user_id = null
where admin_user_id is not null
  and not exists (
    select 1 from public.users u where u.id = a.admin_user_id
  );

-- Làm sạch các bảng nhật ký/quản trị khác nếu chúng tồn tại.
do $$
begin
  if to_regclass('public.admin_activity_logs') is not null then
    update public.admin_activity_logs a
    set admin_user_id = null
    where admin_user_id is not null
      and not exists (select 1 from public.users u where u.id = a.admin_user_id);
  end if;

  if to_regclass('public.password_reset_requests') is not null then
    update public.password_reset_requests a
    set admin_user_id = null
    where admin_user_id is not null
      and not exists (select 1 from public.users u where u.id = a.admin_user_id);
  end if;
end $$;

commit;
