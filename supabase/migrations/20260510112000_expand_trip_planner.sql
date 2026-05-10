create table if not exists public.travel_destinations (
  id text primary key,
  slug text not null unique,
  name text not null,
  region text not null,
  destination_type text not null check (destination_type in ('major', 'minor', 'alternative')),
  latitude numeric(9, 6) not null,
  longitude numeric(9, 6) not null,
  marker_label text not null,
  summary text not null,
  recommended_months text not null,
  recommended_duration text not null,
  main_image_url text,
  image_source_url text,
  image_credit text,
  tags text[] not null default '{}',
  content jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.travel_date_options (
  id text primary key,
  label text not null,
  start_date date not null,
  end_date date not null,
  nights integer not null check (nights in (2, 3)),
  includes_weekend boolean not null default true,
  sort_order integer not null default 0
);

create table if not exists public.travel_transport_options (
  id text primary key,
  destination_id text not null references public.travel_destinations(id) on delete cascade,
  mode text not null check (mode in ('ktx_local', 'car_only', 'ktx_rental')),
  label text not null,
  route_steps jsonb not null default '[]'::jsonb,
  estimated_time text not null,
  estimated_cost text not null,
  requires_car boolean not null default false,
  station_rental_recommended boolean not null default false,
  risk_note text not null default '',
  sort_order integer not null default 0
);

create table if not exists public.travel_trip_preferences (
  id uuid primary key default gen_random_uuid(),
  destination_id text not null references public.travel_destinations(id) on delete cascade,
  date_option_id text not null references public.travel_date_options(id) on delete restrict,
  transport_option_id text not null references public.travel_transport_options(id) on delete restrict,
  voter_name text not null check (length(trim(voter_name)) between 1 and 40),
  voter_token text not null check (length(voter_token) between 16 and 80),
  voter_fingerprint text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (destination_id, voter_fingerprint)
);

create table if not exists public.travel_preference_likes (
  id uuid primary key default gen_random_uuid(),
  preference_id uuid not null references public.travel_trip_preferences(id) on delete cascade,
  liker_token text not null check (length(liker_token) between 16 and 80),
  liker_fingerprint text not null,
  created_at timestamptz not null default now(),
  unique (preference_id, liker_fingerprint)
);

create table if not exists public.travel_destination_comments (
  id uuid primary key default gen_random_uuid(),
  destination_id text not null references public.travel_destinations(id) on delete cascade,
  commenter_name text not null check (length(trim(commenter_name)) between 1 and 40),
  commenter_token text not null check (length(commenter_token) between 16 and 80),
  commenter_fingerprint text not null,
  body text not null check (length(trim(body)) between 1 and 700),
  created_at timestamptz not null default now()
);

create index if not exists travel_transport_options_destination_idx
  on public.travel_transport_options (destination_id, sort_order);

create index if not exists travel_trip_preferences_destination_idx
  on public.travel_trip_preferences (destination_id, updated_at desc);

create index if not exists travel_destination_comments_destination_idx
  on public.travel_destination_comments (destination_id, created_at desc);

drop trigger if exists set_travel_destinations_updated_at on public.travel_destinations;
create trigger set_travel_destinations_updated_at
before update on public.travel_destinations
for each row
execute function public.set_current_timestamp_updated_at();

drop trigger if exists set_travel_trip_preferences_updated_at on public.travel_trip_preferences;
create trigger set_travel_trip_preferences_updated_at
before update on public.travel_trip_preferences
for each row
execute function public.set_current_timestamp_updated_at();

alter table public.travel_destinations enable row level security;
alter table public.travel_date_options enable row level security;
alter table public.travel_transport_options enable row level security;
alter table public.travel_trip_preferences enable row level security;
alter table public.travel_preference_likes enable row level security;
alter table public.travel_destination_comments enable row level security;

drop policy if exists "travel destinations are public readable" on public.travel_destinations;
create policy "travel destinations are public readable"
on public.travel_destinations
for select
to anon, authenticated
using (true);

drop policy if exists "travel date options are public readable" on public.travel_date_options;
create policy "travel date options are public readable"
on public.travel_date_options
for select
to anon, authenticated
using (true);

drop policy if exists "travel transport options are public readable" on public.travel_transport_options;
create policy "travel transport options are public readable"
on public.travel_transport_options
for select
to anon, authenticated
using (true);

revoke insert, update, delete on public.travel_trip_preferences from anon, authenticated;
revoke insert, update, delete on public.travel_preference_likes from anon, authenticated;
revoke insert, update, delete on public.travel_destination_comments from anon, authenticated;
revoke select on public.travel_trip_preferences from anon, authenticated;
revoke select on public.travel_preference_likes from anon, authenticated;
revoke select on public.travel_destination_comments from anon, authenticated;

create or replace function public.list_trip_preferences()
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
language sql
security definer
set search_path = public, pg_temp
as $$
  select
    preferences.id,
    preferences.destination_id,
    preferences.date_option_id,
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
    where id = p_transport_option_id
      and destination_id = p_destination_id
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
    on conflict (destination_id, voter_fingerprint)
    do update set
      date_option_id = excluded.date_option_id,
      transport_option_id = excluded.transport_option_id,
      voter_name = excluded.voter_name,
      voter_token = excluded.voter_token
    returning *
  )
  select
    upserted.id,
    upserted.destination_id,
    upserted.date_option_id,
    upserted.transport_option_id,
    upserted.voter_name,
    0::integer as like_count,
    upserted.created_at,
    upserted.updated_at
  from upserted;
end;
$$;

create or replace function public.toggle_trip_preference_like(
  p_preference_id uuid,
  p_liker_token text
)
returns boolean
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_liker_fingerprint text := encode(extensions.digest(p_liker_token, 'sha256'), 'hex');
  v_deleted_count integer;
begin
  if length(p_liker_token) < 16 or length(p_liker_token) > 80 then
    raise exception 'liker_token must be between 16 and 80 characters';
  end if;

  delete from public.travel_preference_likes
  where preference_id = p_preference_id
    and liker_fingerprint = v_liker_fingerprint;

  get diagnostics v_deleted_count = row_count;

  if v_deleted_count > 0 then
    return false;
  end if;

  insert into public.travel_preference_likes (
    preference_id,
    liker_token,
    liker_fingerprint
  )
  values (
    p_preference_id,
    p_liker_token,
    v_liker_fingerprint
  );

  return true;
end;
$$;

create or replace function public.list_destination_comments()
returns table (
  id uuid,
  destination_id text,
  commenter_name text,
  body text,
  created_at timestamptz
)
language sql
security definer
set search_path = public, pg_temp
as $$
  select
    comments.id,
    comments.destination_id,
    comments.commenter_name,
    comments.body,
    comments.created_at
  from public.travel_destination_comments comments
  order by comments.created_at desc;
$$;

create or replace function public.submit_destination_comment(
  p_destination_id text,
  p_commenter_name text,
  p_commenter_token text,
  p_body text
)
returns table (
  id uuid,
  destination_id text,
  commenter_name text,
  body text,
  created_at timestamptz
)
language plpgsql
security definer
set search_path = public, pg_temp
as $$
declare
  v_commenter_name text := trim(p_commenter_name);
  v_body text := trim(p_body);
  v_commenter_fingerprint text := encode(extensions.digest(p_commenter_token, 'sha256'), 'hex');
begin
  if length(v_commenter_name) < 1 or length(v_commenter_name) > 40 then
    raise exception 'commenter_name must be between 1 and 40 characters';
  end if;

  if length(p_commenter_token) < 16 or length(p_commenter_token) > 80 then
    raise exception 'commenter_token must be between 16 and 80 characters';
  end if;

  if length(v_body) < 1 or length(v_body) > 700 then
    raise exception 'comment body must be between 1 and 700 characters';
  end if;

  return query
  insert into public.travel_destination_comments (
    destination_id,
    commenter_name,
    commenter_token,
    commenter_fingerprint,
    body
  )
  values (
    p_destination_id,
    v_commenter_name,
    p_commenter_token,
    v_commenter_fingerprint,
    v_body
  )
  returning
    travel_destination_comments.id,
    travel_destination_comments.destination_id,
    travel_destination_comments.commenter_name,
    travel_destination_comments.body,
    travel_destination_comments.created_at;
end;
$$;

revoke all on function public.list_trip_preferences() from public;
revoke all on function public.submit_trip_preference(text, text, text, text, text) from public;
revoke all on function public.toggle_trip_preference_like(uuid, text) from public;
revoke all on function public.list_destination_comments() from public;
revoke all on function public.submit_destination_comment(text, text, text, text) from public;

grant execute on function public.list_trip_preferences() to anon, authenticated;
grant execute on function public.submit_trip_preference(text, text, text, text, text) to anon, authenticated;
grant execute on function public.toggle_trip_preference_like(uuid, text) to anon, authenticated;
grant execute on function public.list_destination_comments() to anon, authenticated;
grant execute on function public.submit_destination_comment(text, text, text, text) to anon, authenticated;

insert into public.travel_date_options (
  id,
  label,
  start_date,
  end_date,
  nights,
  includes_weekend,
  sort_order
) values
  ('2026-06-26-28', '6월 26일-28일 금토일', '2026-06-26', '2026-06-28', 2, true, 10),
  ('2026-07-03-05', '7월 3일-5일 금토일', '2026-07-03', '2026-07-05', 2, true, 20),
  ('2026-08-28-30', '8월 28일-30일 금토일', '2026-08-28', '2026-08-30', 2, true, 30),
  ('2026-09-11-13', '9월 11일-13일 금토일', '2026-09-11', '2026-09-13', 2, true, 40),
  ('2026-08-27-30', '8월 27일-30일 목금토일', '2026-08-27', '2026-08-30', 3, true, 50),
  ('2026-09-10-13', '9월 10일-13일 목금토일', '2026-09-10', '2026-09-13', 3, true, 60)
on conflict (id) do update set
  label = excluded.label,
  start_date = excluded.start_date,
  end_date = excluded.end_date,
  nights = excluded.nights,
  includes_weekend = excluded.includes_weekend,
  sort_order = excluded.sort_order;

insert into public.travel_destinations (
  id,
  slug,
  name,
  region,
  destination_type,
  latitude,
  longitude,
  marker_label,
  summary,
  recommended_months,
  recommended_duration,
  main_image_url,
  image_source_url,
  image_credit,
  tags,
  content
) values
  (
    'busan-haeundae-gwangalli',
    'busan-haeundae-gwangalli',
    '부산 해운대/광안리',
    '부산광역시',
    'major',
    35.158700,
    129.160400,
    '부산',
    'KTX 접근성이 좋고 해변, 야경, 해산물, 요트/드론쇼까지 한 번에 묶기 쉬운 대형 후보지.',
    '6월 말, 7월 초, 8월 말, 9월 초',
    '3박4일 추천, 빡빡하게는 2박3일',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1400&q=80',
    'https://unsplash.com/',
    'Unsplash',
    array['KTX친화', '대도시', '해변', '야경', '차없이가능'],
    '{
      "fit": "7-8명이 각자 취향을 나눠도 일정 분리가 쉬운 안전한 선택지",
      "sourceUrls": ["https://www.visitbusan.net/en/index.do", "https://www.busan.go.kr/eng/visitbusan"],
      "reviewThemes": ["광안리 야경과 해변 산책 만족도가 높음", "해운대/광안리 숙소 가격은 성수기와 주말 변동이 큼", "차 없이도 움직일 수 있지만 밤 이동은 택시 대기 고려"],
      "attractions": [
        {"name":"해운대 해수욕장","kind":"beach","description":"대표 해변과 주변 음식점, 카페 밀도가 높은 구간","sourceUrl":"https://www.visitbusan.net/en/index.do","mapUrl":"https://map.naver.com/p/search/%ED%95%B4%EC%9A%B4%EB%8C%80%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5"},
        {"name":"광안리 해수욕장","kind":"night view","description":"광안대교 야경과 주말 드론쇼 확인 후보","sourceUrl":"https://www.visitbusan.net/en/index.do","mapUrl":"https://map.kakao.com/?q=%EA%B4%91%EC%95%88%EB%A6%AC%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5"},
        {"name":"민락수변공원/회센터","kind":"food","description":"회, 포장, 해변 야식 동선을 만들기 쉬움","sourceUrl":"https://www.visitbusan.net/en/index.do","mapUrl":"https://www.google.com/maps/search/?api=1&query=Millak+Waterfront+Park+Busan"},
        {"name":"동백섬","kind":"walk","description":"해운대와 묶기 쉬운 짧은 산책 코스","sourceUrl":"https://www.visitbusan.net/en/index.do","mapUrl":"https://map.naver.com/p/search/%EB%8F%99%EB%B0%B1%EC%84%AC"}
      ],
      "stays": [
        {"name":"광안리 오션뷰 에어비앤비형 숙소","area":"광안리", "notes":"야경 중심 일정이면 단체 숙소 만족도가 높음. 엘리베이터, 방 개수, 소음 규정 확인"},
        {"name":"해운대 레지던스형 숙소","area":"해운대", "notes":"KTX 후 지하철 접근과 짐 이동이 편함. 주말 가격과 침대 수 확인"},
        {"name":"송정/기장 풀빌라형 펜션","area":"송정/기장", "notes":"차량 또는 택시 이동 전제. 바비큐/수영장 중심이면 후보"}
      ],
      "activities": [
        {"name":"광안리 요트/해상 액티비티","risk":"강풍/우천 취소 가능"},
        {"name":"해변 피크닉과 야경 산책","risk":"성수기 혼잡"},
        {"name":"해산물 시장/포차 투어","risk":"예산 개인차"}
      ]
    }'::jsonb
  ),
  (
    'gangneung-yangyang',
    'gangneung-yangyang',
    '강릉/양양 동해안',
    '강원 강릉시/양양군',
    'major',
    37.751900,
    128.876100,
    '강릉',
    '서울에서 짧게 가기 좋은 동해안 조합. 강릉은 KTX, 양양은 서핑과 해변 분위기가 강점.',
    '6월 말, 7월 초, 8월 말, 9월 초',
    '2박3일 최적',
    'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1400&q=80',
    'https://unsplash.com/',
    'Unsplash',
    array['KTX친화', '동해', '서핑', '카페', '2박3일'],
    '{
      "fit": "잠실 출발 주말 2박3일로 가장 현실적인 바다 후보",
      "sourceUrls": ["https://www.gangneung.go.kr/eng/sub04_01_01.do", "https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=34381"],
      "reviewThemes": ["강릉은 카페/해변 동선이 쉬움", "양양 서피비치는 서핑 체험 목적이면 만족도가 높음", "양양까지는 렌터카나 택시 비용이 변수"],
      "attractions": [
        {"name":"경포해변","kind":"beach","description":"강릉 대표 해변, 숙소와 카페 선택지가 많음","sourceUrl":"https://www.gangneung.go.kr/eng/sub04_01_01.do","mapUrl":"https://map.naver.com/p/search/%EA%B2%BD%ED%8F%AC%ED%95%B4%EB%B3%80"},
        {"name":"안목 커피거리","kind":"cafe","description":"도보 산책과 카페 일정에 적합","sourceUrl":"https://www.gangneung.go.kr/eng/sub04_01_01.do","mapUrl":"https://map.kakao.com/?q=%EC%95%88%EB%AA%A9%EC%BB%A4%ED%94%BC%EA%B1%B0%EB%A6%AC"},
        {"name":"주문진/향호해변","kind":"photo","description":"강릉 북쪽 사진 코스","sourceUrl":"https://www.gangneung.go.kr/eng/sub04_01_01.do","mapUrl":"https://www.google.com/maps/search/?api=1&query=Jumunjin+Beach"},
        {"name":"양양 서피비치","kind":"surfing","description":"서핑 체험과 젊은 해변 분위기","sourceUrl":"https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=34381","mapUrl":"https://map.naver.com/p/search/%EC%96%91%EC%96%91%20%EC%84%9C%ED%94%BC%EB%B9%84%EC%B9%98"}
      ],
      "stays": [
        {"name":"경포/강문 단체 레지던스","area":"강릉 해변권", "notes":"차 없이 움직이기 쉽지만 침실 수와 주차 확인"},
        {"name":"사천/주문진 독채 펜션","area":"강릉 북부", "notes":"7-8명 바비큐형 일정에 적합. 차량 권장"},
        {"name":"인구/죽도 해변 펜션","area":"양양", "notes":"서핑 목적이면 위치 좋음. 밤 소음과 체크인 규정 확인"}
      ],
      "activities": [
        {"name":"양양 서핑 강습","risk":"파도/날씨 영향"},
        {"name":"안목/강문 카페 투어","risk":"주차 혼잡"},
        {"name":"해변 바비큐 숙소 일정","risk":"숙소 규정 확인 필요"}
      ]
    }'::jsonb
  ),
  (
    'yeosu-night-sea',
    'yeosu-night-sea',
    '여수 밤바다',
    '전라남도 여수시',
    'major',
    34.760400,
    127.662200,
    '여수',
    'KTX로 접근 가능한 남해안 후보. 야경, 케이블카, 오동도, 해산물 중심의 3박4일 일정에 강함.',
    '6월 말, 8월 말, 9월 초',
    '3박4일 추천',
    'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1400&q=80',
    'https://unsplash.com/',
    'Unsplash',
    array['KTX친화', '남해', '야경', '해산물', '3박4일'],
    '{
      "fit": "술/야경/해산물/산책 취향이 섞인 친구 모임에 적합",
      "sourceUrls": ["https://www.yeosu.go.kr/en/travel/10tour/cablecar"],
      "reviewThemes": ["케이블카와 밤바다 만족도가 높음", "오동도와 낭만포차 거리가 묶기 쉬움", "성수기에는 숙소와 택시 대기가 변수"],
      "attractions": [
        {"name":"여수 해상케이블카","kind":"view","description":"돌산과 자산공원을 잇는 대표 야경 코스","sourceUrl":"https://www.yeosu.go.kr/en/travel/10tour/cablecar","mapUrl":"https://map.naver.com/p/search/%EC%97%AC%EC%88%98%ED%95%B4%EC%83%81%EC%BC%80%EC%9D%B4%EB%B8%94%EC%B9%B4"},
        {"name":"오동도","kind":"walk","description":"바다 산책과 사진 코스","sourceUrl":"https://www.yeosu.go.kr/en/travel/10tour/cablecar","mapUrl":"https://map.kakao.com/?q=%EC%98%A4%EB%8F%99%EB%8F%84"},
        {"name":"낭만포차 거리","kind":"food","description":"밤 일정의 중심 후보","sourceUrl":"https://www.yeosu.go.kr/en/travel/10tour/cablecar","mapUrl":"https://www.google.com/maps/search/?api=1&query=Yeosu+romantic+pocha+street"},
        {"name":"향일암","kind":"sunrise","description":"렌터카 일정이면 넣기 좋은 일출/전망 코스","sourceUrl":"https://www.yeosu.go.kr/en/travel/10tour/cablecar","mapUrl":"https://map.naver.com/p/search/%ED%96%A5%EC%9D%BC%EC%95%94"}
      ],
      "stays": [
        {"name":"종포/해양공원 주변 단체 숙소","area":"여수 시내", "notes":"밤바다와 포차 접근 좋음. 소음/주차 확인"},
        {"name":"돌산 오션뷰 풀빌라","area":"돌산", "notes":"차량 있으면 만족도 높음. 인원 추가요금 확인"},
        {"name":"엑스포역 인근 레지던스","area":"여수엑스포역", "notes":"KTX 도착 후 짐 이동이 쉬움"}
      ],
      "activities": [
        {"name":"해상케이블카 야경","risk":"강풍 시 운영 확인"},
        {"name":"해산물/포차 투어","risk":"대기와 예산 차이"},
        {"name":"돌산 드라이브","risk":"렌터카 필요"}
      ]
    }'::jsonb
  ),
  (
    'taean-anmyeondo',
    'taean-anmyeondo',
    '태안/안면도',
    '충청남도 태안군',
    'minor',
    36.500800,
    126.342900,
    '태안',
    '대중교통보다는 차가 편한 서해 후보. 독채 펜션, 바비큐, 석양, 느슨한 일정에 강함.',
    '6월 말, 8월 말, 9월 초',
    '2박3일 추천',
    'https://images.unsplash.com/photo-1493558103817-58b2924bce98?auto=format&fit=crop&w=1400&q=80',
    'https://unsplash.com/',
    'Unsplash',
    array['차량권장', '서해', '석양', '펜션', '바비큐'],
    '{
      "fit": "7-8명이 한 숙소에 모여 쉬는 여행이면 가장 편한 후보",
      "sourceUrls": ["https://www.taean.go.kr/eng/sub02_02.do"],
      "reviewThemes": ["꽃지 일몰과 펜션 휴식 만족도가 높음", "차량 없이는 동선 제약이 큼", "성수기 독채 숙소 예약이 빨리 마감"],
      "attractions": [
        {"name":"꽃지해수욕장","kind":"sunset","description":"할미할아비바위 일몰 코스","sourceUrl":"https://www.taean.go.kr/eng/sub02_02.do","mapUrl":"https://map.naver.com/p/search/%EA%BD%83%EC%A7%80%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5"},
        {"name":"안면도 자연휴양림","kind":"forest","description":"비치 일정이 지칠 때 넣기 좋은 숲 코스","sourceUrl":"https://www.taean.go.kr/eng/sub02_02.do","mapUrl":"https://map.kakao.com/?q=%EC%95%88%EB%A9%B4%EB%8F%84%EC%9E%90%EC%97%B0%ED%9C%B4%EC%96%91%EB%A6%BC"},
        {"name":"만리포해수욕장","kind":"beach","description":"서핑/해변 후보","sourceUrl":"https://www.taean.go.kr/eng/sub02_02.do","mapUrl":"https://www.google.com/maps/search/?api=1&query=Mallipo+Beach"},
        {"name":"천리포수목원","kind":"garden","description":"사진과 산책에 좋은 대안 코스","sourceUrl":"https://www.taean.go.kr/eng/sub02_02.do","mapUrl":"https://map.naver.com/p/search/%EC%B2%9C%EB%A6%AC%ED%8F%AC%EC%88%98%EB%AA%A9%EC%9B%90"}
      ],
      "stays": [
        {"name":"꽃지/방포 독채 펜션","area":"안면도 남부", "notes":"바비큐, 주차, 방 개수 확인. 7-8명에 적합"},
        {"name":"만리포 해변 펜션","area":"태안 북부", "notes":"해변 접근 좋고 서핑 일정 가능. 차 필수"},
        {"name":"풀빌라형 대형 숙소","area":"안면도", "notes":"숙소 중심 여행이면 유력. 예약 가능 여부 최우선 확인"}
      ],
      "activities": [
        {"name":"꽃지 일몰 피크닉","risk":"날씨 영향"},
        {"name":"숙소 바비큐/보드게임","risk":"숙소 규정 확인"},
        {"name":"해변 드라이브","risk":"운전자 부담"}
      ]
    }'::jsonb
  ),
  (
    'tongyeong-geoje',
    'tongyeong-geoje',
    '통영/거제',
    '경상남도 통영시/거제시',
    'minor',
    34.854400,
    128.433200,
    '통영',
    '섬, 케이블카, 루지, 해안 드라이브가 강한 남해안 후보. KTX 이후 렌터카 조합이 현실적.',
    '6월 말, 8월 말, 9월 초',
    '3박4일 추천',
    'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1400&q=80',
    'https://unsplash.com/',
    'Unsplash',
    array['렌터카추천', '남해', '섬', '루지', '3박4일'],
    '{
      "fit": "액티비티와 드라이브를 좋아하는 팀이면 여행감이 가장 큼",
      "sourceUrls": ["https://tongyeong.skylineluge.kr/en/tongyeong/", "https://skylineenterprises.co.nz/what-we-do/tourism-operations/skyline-luge-tongyeong/"],
      "reviewThemes": ["루지와 케이블카가 대표 액티비티", "차가 있으면 거제까지 확장 가능", "대중교통만으로는 피로도가 높음"],
      "attractions": [
        {"name":"통영 케이블카/미륵산","kind":"view","description":"한려수도 전망 코스","sourceUrl":"https://tongyeong.skylineluge.kr/en/tongyeong/","mapUrl":"https://map.naver.com/p/search/%ED%86%B5%EC%98%81%EC%BC%80%EC%9D%B4%EB%B8%94%EC%B9%B4"},
        {"name":"스카이라인 루지 통영","kind":"activity","description":"단체로 하기 쉬운 대표 액티비티","sourceUrl":"https://tongyeong.skylineluge.kr/en/tongyeong/","mapUrl":"https://map.kakao.com/?q=%EC%8A%A4%EC%B9%B4%EC%9D%B4%EB%9D%BC%EC%9D%B8%EB%A3%A8%EC%A7%80%ED%86%B5%EC%98%81"},
        {"name":"동피랑/강구안","kind":"walk","description":"통영 시내 산책과 먹거리 동선","sourceUrl":"https://tongyeong.skylineluge.kr/en/tongyeong/","mapUrl":"https://www.google.com/maps/search/?api=1&query=Dongpirang+Tongyeong"},
        {"name":"거제 바람의언덕","kind":"coast","description":"차량 일정이면 묶기 좋은 해안 전망","sourceUrl":"https://tongyeong.skylineluge.kr/en/tongyeong/","mapUrl":"https://map.naver.com/p/search/%EA%B1%B0%EC%A0%9C%20%EB%B0%94%EB%9E%8C%EC%9D%98%EC%96%B8%EB%8D%95"}
      ],
      "stays": [
        {"name":"통영항 주변 레지던스","area":"통영 시내", "notes":"술/시장/루지 접근 좋음. 주차 확인"},
        {"name":"거제 오션뷰 독채 펜션","area":"거제 남부", "notes":"해안 드라이브 중심이면 적합. 차 필수"},
        {"name":"산양읍 풀빌라형 숙소","area":"통영 산양", "notes":"조용한 숙소 중심 일정. 장보기 동선 확인"}
      ],
      "activities": [
        {"name":"루지 단체 레이스","risk":"우천 영향"},
        {"name":"한려수도 케이블카","risk":"강풍 운영 확인"},
        {"name":"거제 해안 드라이브","risk":"운전자와 주차 부담"}
      ]
    }'::jsonb
  ),
  (
    'namhae-coast',
    'namhae-coast',
    '남해',
    '경상남도 남해군',
    'alternative',
    34.837700,
    127.892700,
    '남해',
    '덜 뻔한 남해안 휴식 후보. 독일마을, 다랭이마을, 해변과 독채 숙소 조합이 좋다.',
    '6월 말, 8월 말, 9월 초',
    '3박4일 추천',
    'https://images.unsplash.com/photo-1500534314209-a25ddb2bd429?auto=format&fit=crop&w=1400&q=80',
    'https://unsplash.com/',
    'Unsplash',
    array['렌터카필수', '남해', '휴식', '독채', '대안후보'],
    '{
      "fit": "붐비는 곳보다 예쁜 숙소와 바다 휴식을 원하는 팀에 적합",
      "sourceUrls": ["https://www.namhae.go.kr/tour/00007/00023/00200.web", "https://www.namhaetour.org/"],
      "reviewThemes": ["풍경과 숙소 만족도는 높지만 이동거리가 길다", "독일마을은 호불호가 있어 보조 코스로 적합", "렌터카 없이는 일정 구성이 어렵다"],
      "attractions": [
        {"name":"가천 다랭이마을","kind":"scenery","description":"남해 대표 계단식 마을과 바다 전망","sourceUrl":"https://www.namhae.go.kr/tour/00007/00023/00200.web","mapUrl":"https://map.naver.com/p/search/%EB%82%A8%ED%95%B4%20%EB%8B%A4%EB%9E%AD%EC%9D%B4%EB%A7%88%EC%9D%84"},
        {"name":"남해 독일마을","kind":"photo","description":"사진과 카페 중심의 짧은 코스","sourceUrl":"https://www.namhaetour.org/","mapUrl":"https://map.kakao.com/?q=%EB%82%A8%ED%95%B4%EB%8F%85%EC%9D%BC%EB%A7%88%EC%9D%84"},
        {"name":"상주은모래비치","kind":"beach","description":"남해 대표 해변 후보","sourceUrl":"https://www.namhaetour.org/","mapUrl":"https://www.google.com/maps/search/?api=1&query=Sangju+Silver+Sand+Beach"},
        {"name":"보리암","kind":"view","description":"차량 이동과 체력 여유가 있으면 넣기 좋은 전망 코스","sourceUrl":"https://www.namhaetour.org/","mapUrl":"https://map.naver.com/p/search/%EB%82%A8%ED%95%B4%20%EB%B3%B4%EB%A6%AC%EC%95%94"}
      ],
      "stays": [
        {"name":"남면/상주 독채 펜션","area":"남해 남부", "notes":"숙소 중심 휴식에 적합. 차 필수"},
        {"name":"독일마을 주변 풀빌라","area":"삼동면", "notes":"사진/카페 접근 좋음. 가격대 확인"},
        {"name":"미조항 근처 대형 숙소","area":"미조", "notes":"해산물과 항구 분위기. 장보기 동선 확인"}
      ],
      "activities": [
        {"name":"남해 해안 드라이브","risk":"운전 피로"},
        {"name":"독채 숙소 바비큐","risk":"성수기 예약"},
        {"name":"다랭이마을 산책","risk":"더위와 경사"}
      ]
    }'::jsonb
  ),
  (
    'pohang-guryongpo',
    'pohang-guryongpo',
    '포항/구룡포',
    '경상북도 포항시',
    'alternative',
    36.019000,
    129.343500,
    '포항',
    'KTX 포항역과 렌터카를 조합하기 좋은 동해안 대안. 스페이스워크, 영일대, 호미곶이 강점.',
    '6월 말, 8월 말, 9월 초',
    '2박3일 또는 3박4일',
    'https://images.unsplash.com/photo-1493558103817-58b2924bce98?auto=format&fit=crop&w=1400&q=80',
    'https://unsplash.com/',
    'Unsplash',
    array['KTX가능', '렌터카추천', '동해', '사진', '대안후보'],
    '{
      "fit": "부산보다 덜 붐비는 동해안 사진/드라이브 후보",
      "sourceUrls": ["https://www.spacewalk.or.kr/front/main/getEngMain.do", "https://pohang.go.kr/phtour/"],
      "reviewThemes": ["스페이스워크와 영일대 야경이 대표 포인트", "호미곶/구룡포는 렌터카가 편함", "강풍 시 스페이스워크 운영 확인 필요"],
      "attractions": [
        {"name":"스페이스워크","kind":"view","description":"포항 대표 체험형 조형물과 영일만 전망","sourceUrl":"https://www.spacewalk.or.kr/front/main/getEngMain.do","mapUrl":"https://map.naver.com/p/search/%ED%8F%AC%ED%95%AD%20%EC%8A%A4%ED%8E%98%EC%9D%B4%EC%8A%A4%EC%9B%8C%ED%81%AC"},
        {"name":"영일대해수욕장","kind":"beach","description":"시내 접근과 야경이 좋은 해변","sourceUrl":"https://pohang.go.kr/phtour/","mapUrl":"https://map.kakao.com/?q=%EC%98%81%EC%9D%BC%EB%8C%80%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5"},
        {"name":"호미곶","kind":"sunrise","description":"상생의 손과 일출 코스","sourceUrl":"https://pohang.go.kr/phtour/","mapUrl":"https://www.google.com/maps/search/?api=1&query=Homigot+Pohang"},
        {"name":"구룡포 일본인가옥거리","kind":"walk","description":"사진과 먹거리 코스","sourceUrl":"https://pohang.go.kr/phtour/","mapUrl":"https://map.naver.com/p/search/%EA%B5%AC%EB%A3%A1%ED%8F%AC%20%EC%9D%BC%EB%B3%B8%EC%9D%B8%EA%B0%80%EC%98%A5%EA%B1%B0%EB%A6%AC"}
      ],
      "stays": [
        {"name":"영일대 오션뷰 숙소","area":"포항 시내", "notes":"KTX+택시 이동 가능. 밤 일정에 좋음"},
        {"name":"구룡포/호미곶 독채 펜션","area":"동해면/구룡포", "notes":"차량 필수. 사진/일출 일정에 적합"},
        {"name":"포항역 렌터카 연계 숙소","area":"북구", "notes":"도착/출발 편의 우선 후보"}
      ],
      "activities": [
        {"name":"스페이스워크 산책","risk":"강풍/우천 운영 확인"},
        {"name":"호미곶 일출 드라이브","risk":"새벽 운전"},
        {"name":"죽도시장 해산물","risk":"개인 예산 차이"}
      ]
    }'::jsonb
  )
on conflict (id) do update set
  slug = excluded.slug,
  name = excluded.name,
  region = excluded.region,
  destination_type = excluded.destination_type,
  latitude = excluded.latitude,
  longitude = excluded.longitude,
  marker_label = excluded.marker_label,
  summary = excluded.summary,
  recommended_months = excluded.recommended_months,
  recommended_duration = excluded.recommended_duration,
  main_image_url = excluded.main_image_url,
  image_source_url = excluded.image_source_url,
  image_credit = excluded.image_credit,
  tags = excluded.tags,
  content = excluded.content;

insert into public.travel_transport_options (
  id,
  destination_id,
  mode,
  label,
  route_steps,
  estimated_time,
  estimated_cost,
  requires_car,
  station_rental_recommended,
  risk_note,
  sort_order
) values
  ('busan-ktx-local', 'busan-haeundae-gwangalli', 'ktx_local', 'KTX + 부산 지하철/택시', '["잠실에서 서울역 또는 수서 이동", "KTX/SRT로 부산역 도착", "지하철 1/2호선 또는 택시로 해운대/광안리 이동"]'::jsonb, '약 3.5-4.5시간', '왕복 열차+시내교통 1인 중상', false, false, '성수기 KTX 좌석과 밤 택시 대기 확인', 10),
  ('busan-car-only', 'busan-haeundae-gwangalli', 'car_only', '차량 직행', '["잠실 출발", "경부고속도로", "부산 해운대/광안리 도착"]'::jsonb, '약 5.5-7.5시간', '유류/통행료+주차+렌트 시 높음', true, false, '장거리 운전 피로와 부산 주차 부담 큼', 20),
  ('busan-ktx-rental', 'busan-haeundae-gwangalli', 'ktx_rental', 'KTX + 부산역 렌터카', '["KTX로 부산역", "부산역 주변 렌터카 픽업", "송정/기장/야경 코스 확장"]'::jsonb, '약 4-5시간', '열차+렌터카로 높음', true, true, '시내만 볼 거면 렌터카 효율 낮음', 30),
  ('gangneung-ktx-local', 'gangneung-yangyang', 'ktx_local', 'KTX + 택시/버스', '["잠실에서 청량리/서울역 이동", "KTX 강릉역 도착", "택시/버스로 경포, 강문, 안목 이동"]'::jsonb, '약 2.5-3.5시간', '왕복 열차+택시 1인 중간', false, false, '양양까지 확장하면 택시비 상승', 10),
  ('gangneung-car-only', 'gangneung-yangyang', 'car_only', '차량 직행', '["잠실 출발", "영동고속도로", "강릉/양양 숙소 도착"]'::jsonb, '약 2.5-5시간', '유류/통행료+주차 중간', true, false, '주말 영동고속도로 정체 편차 큼', 20),
  ('gangneung-ktx-rental', 'gangneung-yangyang', 'ktx_rental', 'KTX + 강릉역 렌터카', '["KTX 강릉역", "강릉역 렌터카", "주문진/양양 서핑 코스 확장"]'::jsonb, '약 3-4시간', '열차+렌터카 중상', true, true, '강릉 시내만 보면 렌터카 불필요', 30),
  ('yeosu-ktx-local', 'yeosu-night-sea', 'ktx_local', 'KTX + 택시', '["잠실에서 용산/수서 이동", "KTX/SRT 계열로 여수엑스포역 도착", "택시로 해양공원/돌산 이동"]'::jsonb, '약 4-5시간', '왕복 열차+택시 1인 중상', false, false, '돌산 숙소면 택시비 누적', 10),
  ('yeosu-car-only', 'yeosu-night-sea', 'car_only', '차량 직행', '["잠실 출발", "호남고속도로/순천 경유", "여수 도착"]'::jsonb, '약 4.5-6.5시간', '유류/통행료+주차 중상', true, false, '장거리 운전과 야간 이동 피로', 20),
  ('yeosu-ktx-rental', 'yeosu-night-sea', 'ktx_rental', 'KTX + 여수엑스포역 렌터카', '["KTX 여수엑스포역", "역 주변 렌터카", "돌산/향일암 확장"]'::jsonb, '약 4.5-5.5시간', '열차+렌터카 높음', true, true, '야경 술 일정과 운전 역할 분리 필요', 30),
  ('taean-ktx-local', 'taean-anmyeondo', 'ktx_local', 'KTX/버스 + 현지 택시', '["잠실에서 서울역/터미널 이동", "천안아산 KTX 또는 태안행 버스", "현지 버스/택시로 안면도 이동"]'::jsonb, '약 4-5.5시간', '교통비는 중간이나 택시 변수 큼', false, false, '7-8명 짐 이동에는 비추천', 10),
  ('taean-car-only', 'taean-anmyeondo', 'car_only', '차량 직행', '["잠실 출발", "서해안고속도로", "태안/안면도 숙소 도착"]'::jsonb, '약 2.5-4.5시간', '유류/통행료+렌트 중간', true, false, '사실상 최우선 이동안. 운전자 배정 필요', 20),
  ('taean-ktx-rental', 'taean-anmyeondo', 'ktx_rental', 'KTX + 천안아산 렌터카', '["KTX 천안아산", "렌터카 픽업", "태안/안면도 이동"]'::jsonb, '약 3.5-5시간', '열차+렌터카 중상', true, true, '렌터카 픽업/반납 시간이 변수', 30),
  ('tongyeong-ktx-local', 'tongyeong-geoje', 'ktx_local', 'KTX + 버스/택시', '["잠실에서 서울역/수서", "KTX로 진주/마산/부산 중 선택", "시외버스 또는 택시로 통영"]'::jsonb, '약 5-6.5시간', '중상', false, false, '환승이 많아 7-8명에게 피로도 높음', 10),
  ('tongyeong-car-only', 'tongyeong-geoje', 'car_only', '차량 직행', '["잠실 출발", "중부내륙/남해고속도로", "통영/거제 숙소 도착"]'::jsonb, '약 4.5-6.5시간', '유류/통행료+렌트 중상', true, false, '운전 피로와 성수기 도로 정체', 20),
  ('tongyeong-ktx-rental', 'tongyeong-geoje', 'ktx_rental', 'KTX + 진주/마산 렌터카', '["KTX 진주 또는 마산", "렌터카 픽업", "통영/거제 해안 이동"]'::jsonb, '약 4.5-6시간', '열차+렌터카 높음', true, true, '가장 현실적인 3박4일 이동안', 30),
  ('namhae-ktx-local', 'namhae-coast', 'ktx_local', 'KTX + 버스/택시', '["잠실에서 서울역/수서", "KTX 진주", "시외버스/택시로 남해 이동"]'::jsonb, '약 5-6.5시간', '중상', false, false, '현지 이동까지 생각하면 비추천', 10),
  ('namhae-car-only', 'namhae-coast', 'car_only', '차량 직행', '["잠실 출발", "남해고속도로", "남해 숙소 도착"]'::jsonb, '약 4.5-6.5시간', '유류/통행료+렌트 중상', true, false, '장거리 운전 부담', 20),
  ('namhae-ktx-rental', 'namhae-coast', 'ktx_rental', 'KTX + 진주역 렌터카', '["KTX 진주역", "렌터카 픽업", "남해 독일마을/다랭이 이동"]'::jsonb, '약 4.5-6시간', '열차+렌터카 높음', true, true, '남해는 렌터카 없으면 만족도 낮음', 30),
  ('pohang-ktx-local', 'pohang-guryongpo', 'ktx_local', 'KTX + 택시/버스', '["잠실에서 서울역 이동", "KTX 포항역", "택시/버스로 영일대 이동"]'::jsonb, '약 3.5-4.5시간', '왕복 열차+택시 중상', false, false, '구룡포/호미곶까지는 택시비 큼', 10),
  ('pohang-car-only', 'pohang-guryongpo', 'car_only', '차량 직행', '["잠실 출발", "중부내륙/상주영천 경유", "포항 도착"]'::jsonb, '약 4-6시간', '유류/통행료+렌트 중상', true, false, '주말 장거리 운전 부담', 20),
  ('pohang-ktx-rental', 'pohang-guryongpo', 'ktx_rental', 'KTX + 포항역 렌터카', '["KTX 포항역", "렌터카 픽업", "영일대/호미곶/구룡포 이동"]'::jsonb, '약 4-5시간', '열차+렌터카 중상', true, true, '동선 확장에는 가장 균형 좋음', 30)
on conflict (id) do update set
  destination_id = excluded.destination_id,
  mode = excluded.mode,
  label = excluded.label,
  route_steps = excluded.route_steps,
  estimated_time = excluded.estimated_time,
  estimated_cost = excluded.estimated_cost,
  requires_car = excluded.requires_car,
  station_rental_recommended = excluded.station_rental_recommended,
  risk_note = excluded.risk_note,
  sort_order = excluded.sort_order;
