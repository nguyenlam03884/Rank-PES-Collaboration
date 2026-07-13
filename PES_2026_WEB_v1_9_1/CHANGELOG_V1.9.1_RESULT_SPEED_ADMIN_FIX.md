# V1.9.1 – Result, Invite Speed & Admin Match Fix

## Rank mechanism verified
- Base win: +21 RP; base loss: -20 RP.
- Same rank ignores RP gap.
- Rank difference changes winner reward by 1 RP per rank, clamped to +19..+24.
- If either player has fewer than 10 matches, rank/RP comparison is ignored.
- A winner in their own first 10 matches receives round(21 × 1.10) = +23 before streak bonus.
- Win streak milestones remain +5, +10, +15, +20; total positive gain capped at +35.
- Club/Tier and score margin do not affect RP.
- Host coefficient ×0.95 is now applied to the actual room host, not implicitly player1.

## Result safety fixes
- Delta RP is normalized to a real integer before database updates and display.
- Missing player IDs or missing player records stop confirmation before RP changes.
- Atomic status claim `processing_result` prevents double-click/repeated confirmation from applying RP twice.
- Short Supabase connection failures use `execute_query` retry on critical result/player updates.
- Achievement/badge synchronization is auxiliary; failure no longer breaks result confirmation.
- Result and admin failures print route, room/match IDs, exception type and message in Vercel logs.
- Invalid score text is handled instead of causing HTTP 500.

## Invite/create-room speed
- Invite availability checks now use small raw selects for active rooms, active matches and pending invites.
- It no longer loads/enriches all rooms, users, achievements and team data merely to send one invite.

## Admin edit/save match
- Validates both player records before changing BXH.
- Reverses the previously applied match before calculating the edited result.
- Uses retry-enabled database calls and provides clear Vercel logs.
- Restores the old match/result on a save failure as a best-effort rollback.
- Shows the recalculated RP changes after a successful save.
