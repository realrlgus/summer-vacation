alter table public.travel_trip_preferences
  add column if not exists start_date date,
  add column if not exists end_date date;

update public.travel_trip_preferences preferences
set
  start_date = date_options.start_date,
  end_date = date_options.end_date
from public.travel_date_options date_options
where preferences.date_option_id = date_options.id
  and preferences.start_date is null
  and preferences.end_date is null;

alter table public.travel_trip_preferences
  alter column date_option_id drop not null;

drop function if exists public.list_trip_preferences();

create or replace function public.list_trip_preferences()
returns table (
  id uuid,
  destination_id text,
  date_option_id text,
  start_date date,
  end_date date,
  transport_option_id text,
  voter_name text,
  like_count integer,
  created_at timestamptz,
  updated_at timestamptz
)
language sql
security definer
set search_path = public, pg_temp
as $$
  select
    preferences.id,
    preferences.destination_id,
    preferences.date_option_id,
    preferences.start_date,
    preferences.end_date,
    preferences.transport_option_id,
    preferences.voter_name,
    count(likes.id)::integer as like_count,
    preferences.created_at,
    preferences.updated_at
  from public.travel_trip_preferences preferences
  left join public.travel_preference_likes likes
    on likes.preference_id = preferences.id
  group by preferences.id
  order by preferences.updated_at desc;
$$;

create or replace function public.submit_trip_preference_dates(
  p_destination_id text,
  p_start_date date,
  p_end_date date,
  p_transport_option_id text,
  p_voter_name text,
  p_voter_token text
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
  v_nights integer := p_end_date - p_start_date;
  v_has_weekend boolean;
begin
  if length(v_voter_name) < 1 or length(v_voter_name) > 40 then
    raise exception 'voter_name must be between 1 and 40 characters';
  end if;

  if length(p_voter_token) < 16 or length(p_voter_token) > 80 then
    raise exception 'voter_token must be between 16 and 80 characters';
  end if;

  if p_start_date is null or p_end_date is null then
    raise exception 'start_date and end_date are required';
  end if;

  if p_start_date < date '2026-06-01' or p_end_date > date '2026-09-30' then
    raise exception 'travel dates must be between 2026-06-01 and 2026-09-30';
  end if;

  if v_nights not in (2, 3) then
    raise exception 'travel duration must be 2 nights 3 days or 3 nights 4 days';
  end if;

  select exists (
    select 1
    from generate_series(p_start_date, p_end_date, interval '1 day') as travel_day(day_value)
    where extract(isodow from travel_day.day_value) in (6, 7)
  )
  into v_has_weekend;

  if not v_has_weekend then
    raise exception 'travel dates must include a weekend';
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
      start_date,
      end_date,
      transport_option_id,
      voter_name,
      voter_token,
      voter_fingerprint
    )
    values (
      p_destination_id,
      null,
      p_start_date,
      p_end_date,
      p_transport_option_id,
      v_voter_name,
      p_voter_token,
      v_voter_fingerprint
    )
    on conflict on constraint travel_trip_preferences_destination_id_voter_fingerprint_key
    do update set
      date_option_id = null,
      start_date = excluded.start_date,
      end_date = excluded.end_date,
      transport_option_id = excluded.transport_option_id,
      voter_name = excluded.voter_name,
      voter_token = excluded.voter_token
    returning
      travel_trip_preferences.id as preference_id,
      travel_trip_preferences.destination_id as preference_destination_id,
      travel_trip_preferences.date_option_id as preference_date_option_id,
      travel_trip_preferences.start_date as preference_start_date,
      travel_trip_preferences.end_date as preference_end_date,
      travel_trip_preferences.transport_option_id as preference_transport_option_id,
      travel_trip_preferences.voter_name as preference_voter_name,
      travel_trip_preferences.created_at as preference_created_at,
      travel_trip_preferences.updated_at as preference_updated_at
  )
  select
    upserted.preference_id,
    upserted.preference_destination_id,
    upserted.preference_date_option_id,
    upserted.preference_start_date,
    upserted.preference_end_date,
    upserted.preference_transport_option_id,
    upserted.preference_voter_name,
    0::integer as like_count,
    upserted.preference_created_at,
    upserted.preference_updated_at
  from upserted;
end;
$$;

revoke all on function public.list_trip_preferences() from public;
revoke all on function public.submit_trip_preference_dates(text, date, date, text, text, text)
from public;

grant execute on function public.list_trip_preferences() to anon, authenticated;
grant execute on function public.submit_trip_preference_dates(text, date, date, text, text, text)
to anon, authenticated;
