-- PES eFootball 2026 Web V1.6.2
-- ONE FILE SETUP for a brand-new Supabase project.
-- Run this once in Supabase SQL Editor before deploying V1.6.2 code.
-- Safe to run again: uses IF NOT EXISTS / ON CONFLICT and does not delete data.

create extension if not exists "pgcrypto";

-- Core users
create table if not exists public.users (
    id uuid primary key default gen_random_uuid(),
    username text unique not null,
    password_hash text not null,
    display_name text not null,
    role text not null default 'player',
    rank_points integer not null default 1000,
    total_matches integer not null default 0,
    wins integer not null default 0,
    draws integer not null default 0,
    losses integer not null default 0,
    goals_for integer not null default 0,
    goals_against integer not null default 0,
    streak integer not null default 0,
    is_online boolean not null default false,
    last_seen_at timestamptz,
    matchmaking_cooldown_until timestamptz,
    register_ip text,
    register_user_agent text,
    zalo_name text,
    account_status text not null default 'pending',
    admin_level text not null default 'none',
    admin_can_create_test_account boolean not null default false,
    admin_can_import_accounts_csv boolean not null default false,
    approved_by uuid references public.users(id) on delete set null,
    approved_at timestamptz,
    rejection_reason text,
    invite_code_used text,
    must_change_password boolean not null default false,
    password_changed_at timestamptz,
    avatar_url text,
    avatar_path text,
    avatar_updated_at timestamptz,
    display_name_change_count integer not null default 0,
    display_name_changed_at timestamptz,
    created_at timestamptz not null default now()
);

alter table public.users add column if not exists last_seen_at timestamptz;
alter table public.users add column if not exists matchmaking_cooldown_until timestamptz;
alter table public.users add column if not exists register_ip text;
alter table public.users add column if not exists register_user_agent text;
alter table public.users add column if not exists zalo_name text;
alter table public.users add column if not exists account_status text;
alter table public.users add column if not exists admin_level text not null default 'none';
alter table public.users add column if not exists admin_can_create_test_account boolean not null default false;
alter table public.users add column if not exists admin_can_import_accounts_csv boolean not null default false;
alter table public.users add column if not exists approved_by uuid references public.users(id) on delete set null;
alter table public.users add column if not exists approved_at timestamptz;
alter table public.users add column if not exists rejection_reason text;
alter table public.users add column if not exists invite_code_used text;
alter table public.users add column if not exists must_change_password boolean not null default false;
alter table public.users add column if not exists password_changed_at timestamptz;
alter table public.users add column if not exists avatar_url text;
alter table public.users add column if not exists avatar_path text;
alter table public.users add column if not exists avatar_updated_at timestamptz;
alter table public.users add column if not exists display_name_change_count integer not null default 0;
alter table public.users add column if not exists display_name_changed_at timestamptz;

update public.users set account_status = 'approved' where account_status is null;
alter table public.users alter column account_status set default 'pending';
alter table public.users alter column account_status set not null;
alter table public.users alter column rank_points set default 1000;

-- Core matches
create table if not exists public.matches (
    id uuid primary key default gen_random_uuid(),
    player1_id uuid not null references public.users(id) on delete restrict,
    player2_id uuid not null references public.users(id) on delete restrict,
    team1 text not null,
    team2 text not null,
    score1 integer,
    score2 integer,
    submitted_by_id uuid references public.users(id) on delete set null,
    winner_id uuid references public.users(id) on delete set null,
    loser_id uuid references public.users(id) on delete set null,
    delta1 integer not null default 0,
    delta2 integer not null default 0,
    team1_league text,
    team2_league text,
    host_xp_factor numeric(4,2) not null default 1.00,
    status text not null default 'playing',
    note text,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

-- Device guard
create table if not exists public.user_devices (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null references public.users(id) on delete cascade,
    device_id text unique not null,
    ip_address text,
    user_agent text,
    created_at timestamptz not null default now(),
    last_seen_at timestamptz not null default now()
);

-- Invites and match rooms
create table if not exists public.match_invites (
    id uuid primary key default gen_random_uuid(),
    from_user_id uuid not null references public.users(id) on delete cascade,
    to_user_id uuid not null references public.users(id) on delete cascade,
    tier text not null default 'Random',
    status text not null default 'pending',
    message text,
    expires_at timestamptz,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create table if not exists public.match_rooms (
    id uuid primary key default gen_random_uuid(),
    invite_id uuid references public.match_invites(id) on delete set null,
    host_user_id uuid not null references public.users(id) on delete restrict,
    guest_user_id uuid not null references public.users(id) on delete restrict,
    host_team text,
    guest_team text,
    team_tier text not null default 'Random',
    match_mode text not null default 'ranked',
    friendly_tier text,
    host_team_league text,
    guest_team_league text,
    guest_ready boolean not null default false,
    status text not null default 'waiting_ready',
    match_id uuid references public.matches(id) on delete set null,
    host_score integer,
    guest_score integer,
    submitted_by_id uuid references public.users(id) on delete set null,
    confirmed_by_id uuid references public.users(id) on delete set null,
    state_expires_at timestamptz,
    note text,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

alter table public.match_invites add column if not exists expires_at timestamptz;
alter table public.match_rooms add column if not exists state_expires_at timestamptz;

-- Chat and announcements
create table if not exists public.chat_messages (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null references public.users(id) on delete cascade,
    room_id uuid references public.match_rooms(id) on delete cascade,
    scope text not null default 'global',
    message text not null,
    created_at timestamptz not null default now()
);

create table if not exists public.admin_announcements (
    id uuid primary key default gen_random_uuid(),
    admin_user_id uuid references public.users(id) on delete set null,
    title text not null default 'THÔNG BÁO',
    message text not null,
    is_active boolean not null default true,
    created_at timestamptz not null default now()
);

-- Registration approval and invite codes
create table if not exists public.registration_invite_codes (
    id uuid primary key default gen_random_uuid(),
    code text unique not null,
    label text,
    created_by uuid references public.users(id) on delete set null,
    used_by uuid references public.users(id) on delete set null,
    is_active boolean not null default true,
    created_at timestamptz not null default now(),
    used_at timestamptz
);

-- Password reset requests
create table if not exists public.password_reset_requests (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null references public.users(id) on delete cascade,
    username_snapshot text,
    zalo_name_snapshot text,
    status text not null default 'pending',
    requested_ip text,
    admin_user_id uuid references public.users(id) on delete set null,
    admin_note text,
    created_at timestamptz not null default now(),
    resolved_at timestamptz
);

-- Admin audit log
create table if not exists public.admin_activity_logs (
    id uuid primary key default gen_random_uuid(),
    admin_user_id uuid references public.users(id) on delete set null,
    admin_name text,
    action text not null,
    target_type text,
    target_id text,
    target_label text,
    details text,
    ip_address text,
    created_at timestamptz not null default now()
);

-- Dispute center
create table if not exists public.match_disputes (
    id uuid primary key default gen_random_uuid(),
    match_id uuid not null references public.matches(id) on delete cascade,
    room_id uuid references public.match_rooms(id) on delete cascade,
    raised_by_id uuid references public.users(id) on delete set null,
    reason_code text not null default 'other',
    reason_label text,
    details text,
    source text not null default 'player',
    submitted_score1 integer,
    submitted_score2 integer,
    status text not null default 'pending',
    resolution_type text,
    resolution_score1 integer,
    resolution_score2 integer,
    resolution_note text,
    resolved_by_id uuid references public.users(id) on delete set null,
    evidence_path text,
    evidence_uploaded_at timestamptz,
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),
    resolved_at timestamptz
);

alter table public.match_disputes add column if not exists evidence_path text;
alter table public.match_disputes add column if not exists evidence_uploaded_at timestamptz;

-- Personal notifications
create table if not exists public.user_notifications (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null references public.users(id) on delete cascade,
    notification_type text not null default 'system',
    title text not null,
    message text not null,
    link_url text,
    is_read boolean not null default false,
    created_at timestamptz not null default now(),
    read_at timestamptz
);

-- Achievement badges
create table if not exists public.user_achievements (
    id uuid primary key default gen_random_uuid(),
    user_id uuid not null references public.users(id) on delete cascade,
    achievement_code text not null,
    unlocked_at timestamptz not null default now(),
    created_at timestamptz not null default now(),
    unique (user_id, achievement_code)
);

-- Default owner admin. Password: Do12345
insert into public.users (
    username,
    password_hash,
    display_name,
    role,
    admin_level,
    account_status,
    zalo_name,
    rank_points
)
values (
    'admin',
    'd1515a15096d9cddd04803fcc2ee6132b3729fa25f45d62845a9be1d35fe0e92',
    'Admin',
    'admin',
    'owner',
    'approved',
    'Chủ hệ thống',
    0
)
on conflict (username) do update set
    password_hash = excluded.password_hash,
    role = 'admin',
    admin_level = 'owner',
    account_status = 'approved';

update public.users
set rank_points = 0
where role = 'player'
  and coalesce(total_matches, 0) = 0;

update public.match_invites
set expires_at = now() + interval '60 seconds'
where status = 'pending'
  and expires_at is null;

update public.match_rooms
set state_expires_at = now() + interval '3 minutes'
where status = 'waiting_ready'
  and state_expires_at is null;

update public.match_rooms
set state_expires_at = now() + interval '5 minutes'
where status = 'waiting_result_confirm'
  and state_expires_at is null;

insert into public.match_disputes (
    match_id,
    room_id,
    raised_by_id,
    reason_code,
    reason_label,
    details,
    source,
    submitted_score1,
    submitted_score2,
    status,
    created_at,
    updated_at
)
select
    r.match_id,
    r.id,
    r.guest_user_id,
    'legacy',
    'Tranh chấp từ phiên bản cũ',
    coalesce(r.note, 'Phòng đã ở trạng thái tranh chấp trước khi nâng cấp V1.5.9.'),
    'legacy',
    r.host_score,
    r.guest_score,
    'pending',
    coalesce(r.updated_at, now()),
    now()
from public.match_rooms r
where r.status = 'disputed'
  and r.match_id is not null
  and not exists (
      select 1
      from public.match_disputes d
      where d.match_id = r.match_id
        and d.status in ('pending', 'processing')
  );

insert into public.user_achievements (user_id, achievement_code)
select id, 'first_match' from public.users
where role = 'player' and coalesce(total_matches, 0) >= 1
on conflict (user_id, achievement_code) do nothing;

insert into public.user_achievements (user_id, achievement_code)
select id, 'warrior_20' from public.users
where role = 'player' and coalesce(total_matches, 0) >= 20
on conflict (user_id, achievement_code) do nothing;

insert into public.user_achievements (user_id, achievement_code)
select id, 'winner_10' from public.users
where role = 'player' and coalesce(wins, 0) >= 10
on conflict (user_id, achievement_code) do nothing;

insert into public.user_achievements (user_id, achievement_code)
select id, 'goals_50' from public.users
where role = 'player' and coalesce(goals_for, 0) >= 50
on conflict (user_id, achievement_code) do nothing;

insert into public.user_achievements (user_id, achievement_code)
select id, 'hot_streak_5' from public.users
where role = 'player' and coalesce(streak, 0) >= 5
on conflict (user_id, achievement_code) do nothing;

insert into public.user_achievements (user_id, achievement_code)
select id, 'top_one'
from public.users
where role = 'player' and coalesce(total_matches, 0) >= 5
order by
    coalesce(rank_points, 0) desc,
    coalesce(wins, 0) desc,
    (coalesce(goals_for, 0) - coalesce(goals_against, 0)) desc,
    coalesce(goals_for, 0) desc,
    coalesce(total_matches, 0) desc,
    lower(coalesce(display_name, username)) asc
limit 1
on conflict (user_id, achievement_code) do nothing;

-- Storage buckets
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('avatars', 'avatars', true, 2097152, array['image/jpeg', 'image/png', 'image/webp'])
on conflict (id) do update set
    public = excluded.public,
    file_size_limit = excluded.file_size_limit,
    allowed_mime_types = excluded.allowed_mime_types;

insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('dispute-evidence', 'dispute-evidence', false, 4194304, array['image/jpeg', 'image/png', 'image/webp'])
on conflict (id) do update set
    public = excluded.public,
    file_size_limit = excluded.file_size_limit,
    allowed_mime_types = excluded.allowed_mime_types;

-- Indexes
create index if not exists idx_users_rank_points on public.users(rank_points desc);
create index if not exists idx_users_role_online_last_seen on public.users(role, is_online, last_seen_at desc);
create index if not exists idx_users_account_status_created on public.users(account_status, created_at desc);
create index if not exists idx_users_admin_level on public.users(admin_level);
create index if not exists idx_users_avatar_updated_at on public.users(avatar_updated_at desc nulls last);
create unique index if not exists ux_users_invite_code_used on public.users(invite_code_used) where invite_code_used is not null;

create index if not exists idx_matches_status on public.matches(status);
create index if not exists idx_matches_created_at on public.matches(created_at desc);
create index if not exists idx_matches_status_created on public.matches(status, created_at desc);
create index if not exists idx_matches_players_created on public.matches(player1_id, player2_id, created_at desc);

create index if not exists idx_user_devices_user_id on public.user_devices(user_id);
create index if not exists idx_user_devices_device_id on public.user_devices(device_id);

create index if not exists idx_match_invites_to_user on public.match_invites(to_user_id);
create index if not exists idx_match_invites_from_user on public.match_invites(from_user_id);
create index if not exists idx_match_invites_status on public.match_invites(status);
create index if not exists idx_match_invites_to_status_created on public.match_invites(to_user_id, status, created_at desc);
create index if not exists idx_match_invites_from_status_created on public.match_invites(from_user_id, status, created_at desc);
create index if not exists idx_match_invites_pending_expiry on public.match_invites(status, expires_at);

create index if not exists idx_match_rooms_host on public.match_rooms(host_user_id);
create index if not exists idx_match_rooms_guest on public.match_rooms(guest_user_id);
create index if not exists idx_match_rooms_status on public.match_rooms(status);
create index if not exists idx_match_rooms_status_updated on public.match_rooms(status, updated_at desc);
create index if not exists idx_match_rooms_users_status on public.match_rooms(host_user_id, guest_user_id, status);
create index if not exists idx_match_rooms_status_expiry on public.match_rooms(status, state_expires_at);

create index if not exists idx_chat_messages_scope_created on public.chat_messages(scope, created_at desc);
create index if not exists idx_chat_messages_room_created on public.chat_messages(room_id, created_at desc);
create index if not exists idx_chat_messages_user_created on public.chat_messages(user_id, created_at desc);

create index if not exists idx_admin_announcements_active_created on public.admin_announcements(is_active, created_at desc);
create index if not exists idx_registration_codes_active_created on public.registration_invite_codes(is_active, created_at desc);
create unique index if not exists ux_password_reset_pending_user on public.password_reset_requests(user_id) where status = 'pending';
create index if not exists idx_password_reset_status_created on public.password_reset_requests(status, created_at desc);
create index if not exists idx_admin_activity_logs_created on public.admin_activity_logs(created_at desc);

create unique index if not exists ux_match_disputes_pending_match on public.match_disputes(match_id) where status in ('pending', 'processing');
create index if not exists idx_match_disputes_status_created on public.match_disputes(status, created_at desc);
create index if not exists idx_match_disputes_room on public.match_disputes(room_id);
create index if not exists idx_user_notifications_unread on public.user_notifications(user_id, is_read, created_at desc);
create index if not exists idx_user_achievements_user on public.user_achievements(user_id, unlocked_at desc);

-- Backend uses service-role key, so RLS is disabled for this Flask app.
alter table public.users disable row level security;
alter table public.matches disable row level security;
alter table public.user_devices disable row level security;
alter table public.match_invites disable row level security;
alter table public.match_rooms disable row level security;
alter table public.chat_messages disable row level security;
alter table public.admin_announcements disable row level security;
alter table public.registration_invite_codes disable row level security;
alter table public.password_reset_requests disable row level security;
alter table public.admin_activity_logs disable row level security;
alter table public.match_disputes disable row level security;
alter table public.user_notifications disable row level security;
alter table public.user_achievements disable row level security;
