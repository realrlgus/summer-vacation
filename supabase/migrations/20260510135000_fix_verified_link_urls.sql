update public.travel_destinations
set content = replace(
  content::text,
  'https://www.gangneung.go.kr/eng/sub04_01_01.do',
  'https://www.gn.go.kr/eng/sub04_01_01.do'
)::jsonb
where content::text like '%https://www.gangneung.go.kr/eng/sub04_01_01.do%';

update public.travel_destinations
set content = replace(
  content::text,
  'https://www.spacewalk.or.kr/front/main/getEngMain.do',
  'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=34489'
)::jsonb
where content::text like '%https://www.spacewalk.or.kr/front/main/getEngMain.do%';
