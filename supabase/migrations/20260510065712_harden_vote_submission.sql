alter table public.travel_votes
  add column if not exists voter_fingerprint text;

update public.travel_votes
set voter_fingerprint = encode(digest(voter_token, 'sha256'), 'hex')
where voter_fingerprint is null;

alter table public.travel_votes
  alter column voter_fingerprint set not null;

alter table public.travel_votes
  drop constraint if exists travel_votes_candidate_id_voter_name_key;

alter table public.travel_votes
  drop constraint if exists travel_votes_candidate_id_voter_token_key;

alter table public.travel_votes
  add constraint travel_votes_candidate_id_voter_fingerprint_key
  unique (candidate_id, voter_fingerprint);

drop policy if exists "public can create travel votes" on public.travel_votes;
drop policy if exists "public can update travel votes" on public.travel_votes;

revoke insert, update, delete on public.travel_votes from anon, authenticated;
revoke select on public.travel_votes from anon, authenticated;
grant select (
  id,
  candidate_id,
  voter_name,
  score,
  comment,
  created_at,
  updated_at
) on public.travel_votes to anon, authenticated;

create or replace function public.submit_travel_vote(
  p_candidate_id text,
  p_voter_name text,
  p_voter_token text,
  p_score integer,
  p_comment text default null
)
returns table (
  id uuid,
  candidate_id text,
  voter_name text,
  score integer,
  comment text,
  created_at timestamptz,
  updated_at timestamptz
)
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_voter_name text := trim(p_voter_name);
  v_voter_fingerprint text := encode(extensions.digest(p_voter_token, 'sha256'), 'hex');
  v_comment text := nullif(trim(coalesce(p_comment, '')), '');
begin
  if length(v_voter_name) < 1 or length(v_voter_name) > 40 then
    raise exception 'voter_name must be between 1 and 40 characters';
  end if;

  if length(p_voter_token) < 16 or length(p_voter_token) > 80 then
    raise exception 'voter_token must be between 16 and 80 characters';
  end if;

  if p_score < 1 or p_score > 5 then
    raise exception 'score must be between 1 and 5';
  end if;

  if v_comment is not null and length(v_comment) > 500 then
    raise exception 'comment must be 500 characters or less';
  end if;

  return query
  insert into public.travel_votes (
    candidate_id,
    voter_name,
    voter_token,
    voter_fingerprint,
    score,
    comment
  )
  values (
    p_candidate_id,
    v_voter_name,
    p_voter_token,
    v_voter_fingerprint,
    p_score,
    v_comment
  )
  on conflict on constraint travel_votes_candidate_id_voter_fingerprint_key
  do update set
    voter_name = excluded.voter_name,
    voter_token = excluded.voter_token,
    score = excluded.score,
    comment = excluded.comment
  returning
    travel_votes.id,
    travel_votes.candidate_id,
    travel_votes.voter_name,
    travel_votes.score,
    travel_votes.comment,
    travel_votes.created_at,
    travel_votes.updated_at;
end;
$$;

revoke all on function public.submit_travel_vote(text, text, text, integer, text)
from public;

grant execute on function public.submit_travel_vote(text, text, text, integer, text)
to anon, authenticated;
