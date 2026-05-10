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
) values (
  'mukho-donghae',
  'mukho-donghae',
  '묵호/동해',
  '강원특별자치도 동해시',
  'alternative',
  37.553400,
  129.115500,
  '묵호',
  '묵호항, 논골담길, 묵호등대, 도째비골 스카이밸리를 도보권으로 묶고 어달/망상/추암까지 확장하기 좋은 동해안 후보.',
  '6월 말, 7월, 8월, 9월 초',
  '2박3일 최적',
  'https://commons.wikimedia.org/wiki/Special:Redirect/file/2016%EB%85%84%207%EC%9B%94%2030%EC%9D%BC%20See%26Sea%20DSC04009.jpg',
  'https://commons.wikimedia.org/wiki/File:2016%EB%85%84_7%EC%9B%94_30%EC%9D%BC_See%26Sea_DSC04009.jpg',
  'Wikimedia Commons',
  array['KTX가능', '동해', '항구', '스카이밸리', '2박3일'],
  $${
    "fit": "강릉보다 덜 붐비는 동해 항구 감성에 전망대, 벽화길, 회, 카페, 해변 확장을 같이 넣고 싶은 팀에 적합",
    "sourceUrls": [
      "https://www.dh.go.kr/tour/index.do",
      "https://commons.wikimedia.org/wiki/Category:Mukho_Port"
    ],
    "blogEvidenceUrls": [
      "https://section.blog.naver.com/Search/Post.naver?keyword=%EB%AC%B5%ED%98%B8%20%EC%97%AC%ED%96%89",
      "https://section.blog.naver.com/Search/Post.naver?keyword=%EB%AC%B5%ED%98%B8%208%EC%9D%B8%20%EC%88%99%EC%86%8C",
      "https://section.blog.naver.com/Search/Post.naver?keyword=%EB%8F%84%EC%A7%B8%EB%B9%84%EA%B3%A8%20%EC%8A%A4%EC%B9%B4%EC%9D%B4%EB%B0%B8%EB%A6%AC"
    ],
    "reviewThemes": [
      "동해관광 공식 페이지에서 묵호권역 대표 코스로 도째비골 스카이밸리, 해랑전망대, 묵호등대, 논골담길, 묵호항을 함께 소개함",
      "묵호항과 논골담길, 도째비골은 도보권으로 묶기 좋아 차 없이도 첫날 핵심 코스 구성이 쉬움",
      "어달/망상/추암/무릉계곡까지 넓히면 차량 또는 택시 분승 예산을 잡는 편이 현실적임"
    ],
    "attractions": [
      {"name":"도째비골 스카이밸리","kind":"skywalk","description":"스카이워크, 스카이사이클, 자이언트 슬라이드를 묶는 묵호권 대표 전망 액티비티","sourceUrl":"https://www.dh.go.kr/tour/index.do","mapUrl":"https://map.naver.com/p/search/%EB%8F%99%ED%95%B4%20%EB%8F%84%EC%A7%B8%EB%B9%84%EA%B3%A8%20%EC%8A%A4%EC%B9%B4%EC%9D%B4%EB%B0%B8%EB%A6%AC","imageUrl":"https://commons.wikimedia.org/wiki/Special:Redirect/file/2016%EB%85%84%207%EC%9B%94%2030%EC%9D%BC%20See%26Sea%20DSC04009.jpg","imageSourceUrl":"https://commons.wikimedia.org/wiki/File:2016%EB%85%84_7%EC%9B%94_30%EC%9D%BC_See%26Sea_DSC04009.jpg"},
      {"name":"논골담길","kind":"walk","description":"묵호등대로 오르는 골목 벽화길. 항구 풍경과 카페를 같이 보기 좋음","sourceUrl":"https://www.dh.go.kr/tour/index.do","mapUrl":"https://map.kakao.com/?q=%EB%8F%99%ED%95%B4%20%EB%85%BC%EA%B3%A8%EB%8B%B4%EA%B8%B8","imageUrl":"https://commons.wikimedia.org/wiki/Special:Redirect/file/2016%EB%85%84%207%EC%9B%94%2030%EC%9D%BC%20See%26Sea%20DSC04009.jpg","imageSourceUrl":"https://commons.wikimedia.org/wiki/File:2016%EB%85%84_7%EC%9B%94_30%EC%9D%BC_See%26Sea_DSC04009.jpg"},
      {"name":"묵호등대/묵호항","kind":"port","description":"항구, 등대, 활어센터, 바다 전망을 한 번에 넣는 묵호 핵심 코스","sourceUrl":"https://www.dh.go.kr/tour/index.do","mapUrl":"https://map.naver.com/p/search/%EB%AC%B5%ED%98%B8%EB%93%B1%EB%8C%80%20%EB%AC%B5%ED%98%B8%ED%95%AD","imageUrl":"https://commons.wikimedia.org/wiki/Special:Redirect/file/2016%EB%85%84%207%EC%9B%94%2030%EC%9D%BC%20See%26Sea%20DSC04009.jpg","imageSourceUrl":"https://commons.wikimedia.org/wiki/File:2016%EB%85%84_7%EC%9B%94_30%EC%9D%BC_See%26Sea_DSC04009.jpg"},
      {"name":"어달/망상 해변","kind":"beach","description":"숙소 위치에 따라 물놀이, 회, 카페, 산책을 확장할 수 있는 해변권","sourceUrl":"https://www.dh.go.kr/tour/index.do","mapUrl":"https://map.naver.com/p/search/%EB%8F%99%ED%95%B4%20%EC%96%B4%EB%8B%AC%ED%95%B4%EB%B3%80%20%EB%A7%9D%EC%83%81%ED%95%B4%EB%B3%80"}
    ],
    "stays": [
      {"name":"묵호 8인 Airbnb 공개 검색","area":"묵호항/논골담길/어달","notes":"오션뷰, 방 개수, 바비큐, 주차, 묵호역/동해역 택시 거리 확인.","airbnbUrl":"https://www.airbnb.co.kr/s/%EB%AC%B5%ED%98%B8--%EB%8F%99%ED%95%B4--%EA%B0%95%EC%9B%90%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28","sourceUrls":["https://www.dh.go.kr/tour/index.do"]},
      {"name":"동해/어달 8인 Airbnb 공개 검색","area":"어달/망상/천곡","notes":"해변 접근을 우선하면 어달/망상권, 기차 접근을 우선하면 동해역/묵호역권 확인.","airbnbUrl":"https://www.airbnb.co.kr/s/%EB%8F%99%ED%95%B4--%EA%B0%95%EC%9B%90%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28"}
    ],
    "activities": [
      {"name":"도째비골 스카이워크/슬라이드","risk":"강풍, 우천, 정기 휴무, 현장 대기 확인","imageUrl":"https://commons.wikimedia.org/wiki/Special:Redirect/file/2016%EB%85%84%207%EC%9B%94%2030%EC%9D%BC%20See%26Sea%20DSC04009.jpg","imageSourceUrl":"https://commons.wikimedia.org/wiki/File:2016%EB%85%84_7%EC%9B%94_30%EC%9D%BC_See%26Sea_DSC04009.jpg"},
      {"name":"묵호항 회/카페 투어","risk":"성수기 주차와 식당 대기 확인"},
      {"name":"어달/망상 해변 물놀이","risk":"파도, 해파리, 샤워장 운영 확인"}
    ],
    "costEstimate": {
      "baseDates": {"startDate":"2026-06-26","endDate":"2026-06-28","nights":2,"days":3,"people":8,"checkedAt":"2026-05-10"},
      "lines": [
        {"category":"숙소","label":"Airbnb/단체 숙소 2박","minAmount":650000,"maxAmount":1450000,"note":"묵호항/어달/망상권 8인 숙소 2박. 오션뷰와 바비큐 가능 여부에 따라 변동."},
        {"category":"교통","label":"KTX/무궁화 동해권 왕복","minAmount":520000,"maxAmount":860000,"note":"청량리/서울권에서 동해역 또는 묵호역 진입 후 택시 이동 예상."},
        {"category":"렌트/차량","label":"현지 택시/쏘카 옵션","minAmount":180000,"maxAmount":520000,"note":"묵호항 중심은 택시 가능, 망상/추암/무릉계곡 확장 시 차량 권장."},
        {"category":"현지 비용","label":"스카이밸리/해랑전망대/주차","minAmount":160000,"maxAmount":420000,"note":"도째비골 체험, 택시 분승, 주차, 카페/항구 이동 버퍼."}
      ],
      "assumptions": [
        "8명, 2026-06-26 금요일 체크인, 2026-06-28 일요일 체크아웃, 2박 기준",
        "Airbnb와 쏘카는 실시간 재고/쿠폰/보험/청소비에 따라 최종 금액이 달라져 범위로 계산",
        "식비와 술값은 개인차가 커서 제외하고 숙소, 장거리 이동, 렌트/현지 이동, 대표 액티비티 버퍼만 포함"
      ],
      "sourceUrls": ["https://www.letskorail.com/","https://etk.srail.kr/","https://socar.kr/fare","https://www.airbnb.com/help/article/479"]
    }
  }$$::jsonb
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
  ('mukho-train-local', 'mukho-donghae', 'ktx_local', 'KTX/무궁화 + 택시', '["잠실에서 청량리/서울역 이동", "동해역 또는 묵호역", "택시로 묵호항/숙소 이동"]'::jsonb, '약 3.5-4.5시간', '열차+택시 1인 중상', false, false, '늦은 시간 묵호역 도착편과 숙소 체크인 시간을 같이 확인', 10),
  ('mukho-car-only', 'mukho-donghae', 'car_only', '차량 직행', '["잠실 출발", "영동고속도로/동해고속도로", "묵호항 또는 어달 숙소"]'::jsonb, '약 3-4.5시간', '유류/통행료+렌트 시 중상', true, false, '금요일 저녁 영동고속도로 정체와 해변권 주차 확인', 20)
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
