create or replace function public.submit_trip_preference(
  p_destination_id text,
  p_date_option_id text,
  p_transport_option_id text,
  p_voter_name text,
  p_voter_token text
)
returns table (
  id uuid,
  destination_id text,
  date_option_id text,
  transport_option_id text,
  voter_name text,
  like_count integer,
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
begin
  if length(v_voter_name) < 1 or length(v_voter_name) > 40 then
    raise exception 'voter_name must be between 1 and 40 characters';
  end if;

  if length(p_voter_token) < 16 or length(p_voter_token) > 80 then
    raise exception 'voter_token must be between 16 and 80 characters';
  end if;

  if not exists (
    select 1
    from public.travel_transport_options
    where travel_transport_options.id = p_transport_option_id
      and travel_transport_options.destination_id = p_destination_id
  ) then
    raise exception 'transport option does not belong to destination';
  end if;

  return query
  with upserted as (
    insert into public.travel_trip_preferences (
      destination_id,
      date_option_id,
      transport_option_id,
      voter_name,
      voter_token,
      voter_fingerprint
    )
    values (
      p_destination_id,
      p_date_option_id,
      p_transport_option_id,
      v_voter_name,
      p_voter_token,
      v_voter_fingerprint
    )
    on conflict on constraint travel_trip_preferences_destination_id_voter_fingerprint_key
    do update set
      date_option_id = excluded.date_option_id,
      transport_option_id = excluded.transport_option_id,
      voter_name = excluded.voter_name,
      voter_token = excluded.voter_token
    returning
      travel_trip_preferences.id as preference_id,
      travel_trip_preferences.destination_id as preference_destination_id,
      travel_trip_preferences.date_option_id as preference_date_option_id,
      travel_trip_preferences.transport_option_id as preference_transport_option_id,
      travel_trip_preferences.voter_name as preference_voter_name,
      travel_trip_preferences.created_at as preference_created_at,
      travel_trip_preferences.updated_at as preference_updated_at
  )
  select
    upserted.preference_id,
    upserted.preference_destination_id,
    upserted.preference_date_option_id,
    upserted.preference_transport_option_id,
    upserted.preference_voter_name,
    0::integer as like_count,
    upserted.preference_created_at,
    upserted.preference_updated_at
  from upserted;
end;
$$;

revoke all on function public.submit_trip_preference(text, text, text, text, text)
from public;

grant execute on function public.submit_trip_preference(text, text, text, text, text)
to anon, authenticated;
