-- PES 2026 V1.7.6: cho phép phòng mở không có khách.
-- Chạy một lần trong Supabase SQL Editor trước khi deploy code mới.

alter table public.match_rooms
    alter column guest_user_id drop not null;

comment on column public.match_rooms.guest_user_id is
    'Có thể NULL khi chủ phòng tạo phòng mở hoặc khách đã rời trước khi random đội.';
