-- PES 2026 V1.7.8: league display, friendly mode and host XP factor

alter table public.match_rooms add column if not exists match_mode text not null default 'ranked';
alter table public.match_rooms add column if not exists friendly_tier text;
alter table public.match_rooms add column if not exists host_team_league text;
alter table public.match_rooms add column if not exists guest_team_league text;

alter table public.matches add column if not exists team1_league text;
alter table public.matches add column if not exists team2_league text;
alter table public.matches add column if not exists host_xp_factor numeric(4,2) not null default 1.00;

update public.matches set host_xp_factor = 1.00 where host_xp_factor is null;
