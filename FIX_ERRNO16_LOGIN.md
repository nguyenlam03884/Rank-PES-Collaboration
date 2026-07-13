# Fix Errno 16 Login

- Login retries now create a fresh Supabase/PostgREST HTTP client after a failed connection.
- Login no longer returns HTTP 500 during a temporary database connection failure.
- Background polling frequency was reduced to prevent each browser tab from creating a request storm.
- User lookup selects only fields needed by authentication instead of `select(*)`.
