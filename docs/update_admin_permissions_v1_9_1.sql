-- V1.9.1 - Giới hạn quyền Admin phụ
-- Chạy một lần trong Supabase SQL Editor.

alter table public.users
    add column if not exists admin_can_create_test_account boolean not null default false;

alter table public.users
    add column if not exists admin_can_import_accounts_csv boolean not null default false;

-- Owner vẫn có toàn quyền qua backend. Admin phụ mặc định không có hai quyền này.
