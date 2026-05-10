create or replace function public.list_trip_preferences_for_viewer(
  p_viewer_token text
)
returns table (
  id uuid,
  destination_id text,
  date_option_id text,
  start_date date,
  end_date date,
  transport_option_id text,
  voter_name text,
  like_count integer,
  is_owner boolean,
  created_at timestamptz,
  updated_at timestamptz
)
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_viewer_fingerprint text;
begin
  if length(p_viewer_token) < 16 or length(p_viewer_token) > 80 then
    raise exception 'viewer_token must be between 16 and 80 characters';
  end if;

  v_viewer_fingerprint := encode(extensions.digest(p_viewer_token, 'sha256'), 'hex');

  return query
  select
    preferences.id,
    preferences.destination_id,
    preferences.date_option_id,
    preferences.start_date,
    preferences.end_date,
    preferences.transport_option_id,
    preferences.voter_name,
    count(likes.id)::integer as like_count,
    preferences.voter_fingerprint = v_viewer_fingerprint as is_owner,
    preferences.created_at,
    preferences.updated_at
  from public.travel_trip_preferences preferences
  left join public.travel_preference_likes likes
    on likes.preference_id = preferences.id
  group by preferences.id
  order by preferences.updated_at desc;
end;
$$;

create or replace function public.list_destination_comments_for_viewer(
  p_viewer_token text
)
returns table (
  id uuid,
  destination_id text,
  commenter_name text,
  body text,
  is_owner boolean,
  created_at timestamptz
)
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_viewer_fingerprint text;
begin
  if length(p_viewer_token) < 16 or length(p_viewer_token) > 80 then
    raise exception 'viewer_token must be between 16 and 80 characters';
  end if;

  v_viewer_fingerprint := encode(extensions.digest(p_viewer_token, 'sha256'), 'hex');

  return query
  select
    comments.id,
    comments.destination_id,
    comments.commenter_name,
    comments.body,
    comments.commenter_fingerprint = v_viewer_fingerprint as is_owner,
    comments.created_at
  from public.travel_destination_comments comments
  order by comments.created_at desc;
end;
$$;

create or replace function public.delete_trip_preference(
  p_preference_id uuid,
  p_voter_token text
)
returns boolean
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_voter_fingerprint text;
  v_deleted_count integer;
begin
  if length(p_voter_token) < 16 or length(p_voter_token) > 80 then
    raise exception 'voter_token must be between 16 and 80 characters';
  end if;

  v_voter_fingerprint := encode(extensions.digest(p_voter_token, 'sha256'), 'hex');

  delete from public.travel_trip_preferences preferences
  where preferences.id = p_preference_id
    and preferences.voter_fingerprint = v_voter_fingerprint;

  get diagnostics v_deleted_count = row_count;

  return v_deleted_count > 0;
end;
$$;

create or replace function public.delete_destination_comment(
  p_comment_id uuid,
  p_commenter_token text
)
returns boolean
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_commenter_fingerprint text;
  v_deleted_count integer;
begin
  if length(p_commenter_token) < 16 or length(p_commenter_token) > 80 then
    raise exception 'commenter_token must be between 16 and 80 characters';
  end if;

  v_commenter_fingerprint := encode(extensions.digest(p_commenter_token, 'sha256'), 'hex');

  delete from public.travel_destination_comments comments
  where comments.id = p_comment_id
    and comments.commenter_fingerprint = v_commenter_fingerprint;

  get diagnostics v_deleted_count = row_count;

  return v_deleted_count > 0;
end;
$$;

revoke all on function public.list_trip_preferences_for_viewer(text) from public;
revoke all on function public.list_destination_comments_for_viewer(text) from public;
revoke all on function public.delete_trip_preference(uuid, text) from public;
revoke all on function public.delete_destination_comment(uuid, text) from public;

grant execute on function public.list_trip_preferences_for_viewer(text)
to anon, authenticated;
grant execute on function public.list_destination_comments_for_viewer(text)
to anon, authenticated;
grant execute on function public.delete_trip_preference(uuid, text)
to anon, authenticated;
grant execute on function public.delete_destination_comment(uuid, text)
to anon, authenticated;
