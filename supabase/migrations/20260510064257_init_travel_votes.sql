create extension if not exists pgcrypto;

create table if not exists public.travel_candidates (
  id text primary key,
  category text not null check (
    category in ('destination', 'restaurant', 'attraction', 'stay')
  ),
  title text not null,
  region text,
  description text not null default '',
  image_url text,
  tags text[] not null default '{}',
  data jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create table if not exists public.travel_votes (
  id uuid primary key default gen_random_uuid(),
  candidate_id text not null references public.travel_candidates(id) on delete cascade,
  voter_name text not null check (length(trim(voter_name)) between 1 and 40),
  voter_token text not null check (length(voter_token) between 16 and 80),
  score integer not null check (score between 1 and 5),
  comment text check (comment is null or length(comment) <= 500),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (candidate_id, voter_token)
);

create index if not exists travel_candidates_category_idx
  on public.travel_candidates (category);

create index if not exists travel_votes_candidate_id_idx
  on public.travel_votes (candidate_id);

create or replace function public.set_current_timestamp_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_travel_votes_updated_at on public.travel_votes;

create trigger set_travel_votes_updated_at
before update on public.travel_votes
for each row
execute function public.set_current_timestamp_updated_at();

alter table public.travel_candidates enable row level security;
alter table public.travel_votes enable row level security;

drop policy if exists "travel candidates are public readable" on public.travel_candidates;
create policy "travel candidates are public readable"
on public.travel_candidates
for select
to anon, authenticated
using (true);

drop policy if exists "travel votes are public readable" on public.travel_votes;
create policy "travel votes are public readable"
on public.travel_votes
for select
to anon, authenticated
using (true);

drop policy if exists "public can create travel votes" on public.travel_votes;
create policy "public can create travel votes"
on public.travel_votes
for insert
to anon, authenticated
with check (true);

drop policy if exists "public can update travel votes" on public.travel_votes;
create policy "public can update travel votes"
on public.travel_votes
for update
to anon, authenticated
using (true)
with check (true);

insert into public.travel_candidates (
  id,
  category,
  title,
  region,
  description,
  image_url,
  tags,
  data
) values
  (
    'gangneung-weekend',
    'destination',
    '강릉 주말 여행',
    '강원 강릉',
    '바다, 카페, 해산물 중심으로 가볍게 다녀오기 좋은 친구 여행 후보',
    'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1200&q=80',
    array['바다', '카페', '해산물', '1박2일'],
    '{"budgetLevel":"medium","travelTime":"서울 기준 KTX 약 2시간","reviewThemes":["동선이 쉽다","카페 선택지가 많다","주말 숙소 가격 변동이 크다"],"needsVerification":["숙소 가격","성수기 교통편"]}'::jsonb
  ),
  (
    'sokcho-food-nature',
    'destination',
    '속초 미식/자연 코스',
    '강원 속초',
    '시장 먹거리와 바다, 설악산 근교를 같이 묶을 수 있는 여행 후보',
    'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?auto=format&fit=crop&w=1200&q=80',
    array['시장', '자연', '바다', '드라이브'],
    '{"budgetLevel":"medium","travelTime":"서울 기준 버스 약 2시간 30분","reviewThemes":["먹거리 선택지가 많다","자연 코스 조합이 좋다","차량 여부에 따라 만족도 차이가 있다"],"needsVerification":["주말 교통 정체","숙소 위치"]}'::jsonb
  ),
  (
    'jeonju-food-trip',
    'destination',
    '전주 먹방 여행',
    '전북 전주',
    '한옥마을, 막걸리 골목, 로컬 맛집을 중심으로 한 미식 여행 후보',
    'https://images.unsplash.com/photo-1498654896293-37aacf113fd9?auto=format&fit=crop&w=1200&q=80',
    array['미식', '한옥', '도보', '가성비'],
    '{"budgetLevel":"low","travelTime":"서울 기준 KTX 약 1시간 40분","reviewThemes":["도보 동선이 쉽다","식비 만족도가 높다","관광지가 붐빌 수 있다"],"needsVerification":["식당 휴무일","숙소 주차"]}'::jsonb
  ),
  (
    'ocean-view-pension',
    'stay',
    '오션뷰 펜션 후보',
    '강릉/속초 해변 인근',
    '4-6명 친구 여행에 맞는 바다 접근성 높은 숙소 유형',
    'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1200&q=80',
    array['숙소', '오션뷰', '단체', '주차확인'],
    '{"priceLevel":"medium","capacityFit":"4-6명","reviewThemes":["바다 접근성이 좋다","단체 이용에 적합하다","주차와 방음 확인이 필요하다"],"needsVerification":["정확한 수용 인원","날짜별 가격","예약 가능 여부"]}'::jsonb
  )
on conflict (id) do update set
  category = excluded.category,
  title = excluded.title,
  region = excluded.region,
  description = excluded.description,
  image_url = excluded.image_url,
  tags = excluded.tags,
  data = excluded.data;
