-- PES 2026 V1.8.9
-- Chạy một lần trong Supabase > SQL Editor.

create table if not exists public.system_settings (
    setting_key text primary key,
    setting_value jsonb not null default '{}'::jsonb,
    updated_at timestamptz not null default now(),
    updated_by uuid null references public.users(id) on delete set null
);

alter table public.system_settings enable row level security;

-- Ứng dụng dùng Service Role Key ở phía server, vì vậy không cần policy công khai.
-- Không cấp quyền đọc/ghi bảng cấu hình cho anon hoặc authenticated client.

create index if not exists system_settings_updated_at_idx
    on public.system_settings(updated_at desc);
