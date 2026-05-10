create or replace function public.list_travel_votes()
returns table (
  id uuid,
  candidate_id text,
  voter_name text,
  score integer,
  comment text,
  created_at timestamptz,
  updated_at timestamptz
)
language sql
security definer
set search_path = public, pg_temp
as $$
  select
    travel_votes.id,
    travel_votes.candidate_id,
    travel_votes.voter_name,
    travel_votes.score,
    travel_votes.comment,
    travel_votes.created_at,
    travel_votes.updated_at
  from public.travel_votes
  order by travel_votes.updated_at desc;
$$;

revoke all on function public.list_travel_votes()
from public;

grant execute on function public.list_travel_votes()
to anon, authenticated;
