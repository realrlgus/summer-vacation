with cost_estimates (
  destination_id,
  airbnb_url,
  lodging_min,
  lodging_max,
  lodging_note,
  transport_min,
  transport_max,
  transport_label,
  transport_note,
  rental_min,
  rental_max,
  rental_label,
  rental_note,
  local_min,
  local_max,
  local_label,
  local_note
) as (
  values
    (
      'busan-haeundae-gwangalli',
      'https://www.airbnb.co.kr/s/%EB%B6%80%EC%82%B0--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28',
      900000, 1800000, '해운대/광안리 8인 단체 숙소 2박. 실제 예약 가능 여부와 청소비는 Airbnb에서 확인 필요.',
      960000, 1250000, 'KTX/SRT 왕복', '서울/수서-부산 8명 왕복 범위. 좌석 등급과 조기 예매에 따라 변동.',
      0, 500000, '현지 쏘카/택시 옵션', '부산 시내는 대중교통 가능. 기장/송정 확장 시 차량 또는 택시 비용 추가.',
      180000, 450000, '현지 이동/주차', '지하철, 택시 분승, 야간 이동 버퍼.'
    ),
    (
      'gangneung-yangyang',
      'https://www.airbnb.co.kr/s/%EA%B0%95%EB%A6%89--%EA%B0%95%EC%9B%90%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28',
      700000, 1500000, '경포/강문/양양권 8인 숙소 2박. 서핑권 숙소는 주말 가산 가능.',
      360000, 560000, 'KTX 강릉 왕복', '서울-강릉 8명 왕복 예상 범위. 시간대와 할인에 따라 변동.',
      240000, 650000, '현지 렌트/택시', '강릉만 보면 택시, 양양까지 묶으면 쏘카/렌터카 권장.',
      120000, 360000, '액티비티/이동 버퍼', '서핑 강습, 주차, 짧은 택시 이동 버퍼.'
    ),
    (
      'yeosu-night-sea',
      'https://www.airbnb.co.kr/s/%EC%97%AC%EC%88%98--%EC%A0%84%EB%9D%BC%EB%82%A8%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28',
      800000, 1700000, '종포/돌산/엑스포역 8인 숙소 2박. 오션뷰/풀빌라는 상단 가격대 가능.',
      700000, 1000000, 'KTX 여수 왕복', '용산-여수엑스포 8명 왕복 예상 범위.',
      300000, 750000, '택시/렌터카', '돌산, 향일암 확장 시 차량 비용 증가.',
      180000, 500000, '케이블카/현지 이동', '케이블카, 택시 분승, 주차 버퍼.'
    ),
    (
      'taean-anmyeondo',
      'https://www.airbnb.co.kr/s/%ED%83%9C%EC%95%88--%EC%B6%A9%EC%B2%AD%EB%82%A8%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28',
      650000, 1450000, '안면도/꽃지/만리포 8인 독채 숙소 2박. 바비큐와 인원 추가요금 확인 필요.',
      0, 0, 'KTX 없음', '잠실 기준 차량 직행 또는 렌터카가 현실적인 후보.',
      650000, 1250000, '쏘카/렌터카 2대', '금-일 2박3일 차량 2대, 보험, 유류, 통행료 포함 예상.',
      200000, 520000, '주차/액티비티', '루트 분산, 주차, 수목원/해변 이동 버퍼.'
    ),
    (
      'tongyeong-geoje',
      'https://www.airbnb.co.kr/s/%ED%86%B5%EC%98%81--%EA%B2%BD%EC%83%81%EB%82%A8%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28',
      850000, 1800000, '통영/거제 오션뷰 또는 독채 숙소 2박. 거제 남부는 차량 필수.',
      800000, 1200000, 'KTX/SRT + 환승', '부산/동대구/진주권 이동 후 렌트 조합 예상.',
      550000, 1100000, '역 렌터카/쏘카', '통영-거제 드라이브와 주차까지 고려한 차량 비용.',
      220000, 600000, '루지/케이블카/현지 이동', '루지, 케이블카, 택시/주차 버퍼.'
    ),
    (
      'namhae-coast',
      'https://www.airbnb.co.kr/s/%EB%82%A8%ED%95%B4--%EA%B2%BD%EC%83%81%EB%82%A8%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28',
      800000, 1750000, '남면/상주/삼동면 독채 숙소 2박. 숙소 중심 여행이면 가격 편차 큼.',
      680000, 1050000, 'KTX/SRT + 환승', '진주/여수/순천권 진입 후 차량 이동 조합 예상.',
      650000, 1250000, '렌터카 2대', '남해 내부 이동은 차량 필수에 가까워 2대 기준.',
      120000, 350000, '주차/입장/이동 버퍼', '해안 드라이브, 주차, 짧은 입장료 버퍼.'
    ),
    (
      'pohang-guryongpo',
      'https://www.airbnb.co.kr/s/%ED%8F%AC%ED%95%AD--%EA%B2%BD%EC%83%81%EB%B6%81%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28',
      700000, 1500000, '영일대/구룡포/호미곶 8인 숙소 2박. 오션뷰와 독채 여부에 따라 변동.',
      640000, 920000, 'KTX 포항 왕복', '서울-포항 8명 왕복 예상 범위.',
      280000, 750000, '현지 렌트/택시', '호미곶/구룡포 확장 시 차량 권장.',
      100000, 300000, '주차/현지 이동', '스페이스워크, 죽도시장, 해안 이동 버퍼.'
    ),
    (
      'ganghwa-seokmodo',
      'https://www.airbnb.co.kr/s/%EA%B0%95%ED%99%94%EB%8F%84--%EC%9D%B8%EC%B2%9C--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28',
      600000, 1300000, '강화/석모도 8인 독채 숙소 2박. 금요일 체크인과 바비큐 규정 확인 필요.',
      0, 0, 'KTX 없음', '잠실 출발 차량 직행이 가장 단순한 후보.',
      520000, 1050000, '쏘카/렌터카 2대', '2박3일 차량 2대, 보험, 유류, 통행료 포함 예상.',
      220000, 570000, '루지/온천/주차', '루지, 온천, 주차, 장보기 이동 버퍼.'
    ),
    (
      'boryeong-daecheon',
      'https://www.airbnb.co.kr/s/%EB%B3%B4%EB%A0%B9--%EC%B6%A9%EC%B2%AD%EB%82%A8%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28',
      650000, 1450000, '대천/무창포 8인 숙소 2박. 해수욕장 도보권은 성수기 가산 가능.',
      480000, 900000, '장항선/차량 이동', '대천역 열차 왕복 또는 차량 분승 예상 범위.',
      160000, 520000, '현지 렌트/택시 옵션', '무창포 확장이나 장보기 동선에 따라 추가.',
      160000, 420000, '짚트랙/바이크/주차', '액티비티와 해변 주차 버퍼.'
    ),
    (
      'gunsan-seonyudo',
      'https://www.airbnb.co.kr/s/%EA%B5%B0%EC%82%B0--%EC%A0%84%EB%9D%BC%EB%B6%81%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28',
      700000, 1600000, '군산 시내/선유도/고군산군도 8인 숙소 2박. 섬 숙소는 수량 제한 가능.',
      500000, 760000, 'KTX 익산 왕복', '용산/수서-익산 8명 왕복 후 군산/선유도 이동.',
      550000, 1100000, '익산/군산 렌터카', '선유도와 고군산군도 이동을 위한 차량 2대 예상.',
      120000, 350000, '주차/자전거/현지 이동', '섬 주차, 자전거, 군산 시내 이동 버퍼.'
    ),
    (
      'mokpo-sinan-jeungdo',
      'https://www.airbnb.co.kr/s/%EB%AA%A9%ED%8F%AC--%EC%A0%84%EB%9D%BC%EB%82%A8%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28',
      750000, 1650000, '목포/신안/증도 8인 숙소 2박. 증도 숙소는 날짜별 재고 확인 필요.',
      780000, 1100000, 'KTX/SRT 목포 왕복', '용산/수서-목포 8명 왕복 예상 범위.',
      380000, 900000, '택시/렌터카', '목포만 보면 택시 가능, 증도 확장 시 차량 권장.',
      160000, 460000, '케이블카/갯벌/현지 이동', '케이블카, 주차, 신안 이동 버퍼.'
    )
)
update public.travel_destinations destinations
set content = jsonb_set(
  destinations.content,
  '{costEstimate}',
  jsonb_build_object(
    'baseDates', jsonb_build_object(
      'startDate', '2026-06-26',
      'endDate', '2026-06-28',
      'nights', 2,
      'days', 3,
      'people', 8,
      'checkedAt', '2026-05-10'
    ),
    'lines', jsonb_build_array(
      jsonb_build_object(
        'category', '숙소',
        'label', 'Airbnb/단체 숙소 2박',
        'minAmount', cost_estimates.lodging_min,
        'maxAmount', cost_estimates.lodging_max,
        'note', cost_estimates.lodging_note,
        'sourceUrl', cost_estimates.airbnb_url
      ),
      jsonb_build_object(
        'category', '교통',
        'label', cost_estimates.transport_label,
        'minAmount', cost_estimates.transport_min,
        'maxAmount', cost_estimates.transport_max,
        'note', cost_estimates.transport_note,
        'sourceUrl', 'https://www.letskorail.com/'
      ),
      jsonb_build_object(
        'category', '렌트/차량',
        'label', cost_estimates.rental_label,
        'minAmount', cost_estimates.rental_min,
        'maxAmount', cost_estimates.rental_max,
        'note', cost_estimates.rental_note,
        'sourceUrl', 'https://socar.kr/fare'
      ),
      jsonb_build_object(
        'category', '현지 비용',
        'label', cost_estimates.local_label,
        'minAmount', cost_estimates.local_min,
        'maxAmount', cost_estimates.local_max,
        'note', cost_estimates.local_note,
        'sourceUrl', 'https://socar.kr/fare'
      )
    ),
    'assumptions', jsonb_build_array(
      '8명, 2026-06-26 금요일 체크인, 2026-06-28 일요일 체크아웃, 2박 기준',
      'Airbnb와 쏘카는 실시간 재고/쿠폰/보험/청소비에 따라 최종 금액이 달라져 범위로 계산',
      '식비와 술값은 개인차가 커서 제외하고 숙소, 장거리 이동, 렌트/현지 이동, 대표 액티비티 버퍼만 포함',
      'KTX/SRT는 좌석 등급, 출발역, 조기 예매에 따라 변동'
    ),
    'sourceUrls', jsonb_build_array(
      cost_estimates.airbnb_url,
      'https://www.letskorail.com/',
      'https://etk.srail.kr/',
      'https://socar.kr/fare',
      'https://www.airbnb.com/help/article/479'
    )
  ),
  true
)
from cost_estimates
where destinations.id = cost_estimates.destination_id;
