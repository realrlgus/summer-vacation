update public.travel_destinations
set content = replace(
  content::text,
  'https://www.gn.go.kr/tour/index.do',
  'https://www.gn.go.kr/eng/sub04_01_01.do'
)::jsonb
where content::text like '%https://www.gn.go.kr/tour/index.do%';
