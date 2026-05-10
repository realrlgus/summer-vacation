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
    'ganghwa-seokmodo',
    'ganghwa-seokmodo',
    '강화/석모도',
    '인천광역시 강화군',
    'alternative',
    37.704200,
    126.437600,
    '강화',
    '잠실에서 차로 접근 가능한 가까운 서해 후보. 갯벌, 석양, 루지, 석모도 온천/보문사를 묶기 좋다.',
    '6월 말, 8월 말, 9월 초',
    '2박3일 추천',
    'https://commons.wikimedia.org/wiki/Special:Redirect/file/Ganghwa1.jpg',
    'https://commons.wikimedia.org/wiki/File:Ganghwa1.jpg',
    'Wikimedia Commons',
    array['차량권장', '서해', '근교', '석양', '온천'],
    $${
      "fit": "장거리 이동 부담을 줄이고 숙소 바비큐와 석양 중심으로 쉬기 좋은 서해 근교 후보",
      "sourceUrls": [
        "https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=139945",
        "https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=112017",
        "https://www.ganghwa.go.kr/open_content/english/culture/ganghwa02.jsp"
      ],
      "blogEvidenceUrls": [
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EA%B0%95%ED%99%94%EB%8F%84%20%EC%84%9D%EB%AA%A8%EB%8F%84%20%EC%97%AC%ED%96%89",
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EA%B0%95%ED%99%94%EB%8F%84%208%EC%9D%B8%20%ED%8E%9C%EC%85%98"
      ],
      "reviewThemes": [
        "서울권에서 가까워 금요일 퇴근 후 출발 부담이 낮음",
        "석양, 갯벌, 루지, 온천처럼 일정 성격을 나누기 쉬움",
        "대중교통만으로는 단체 이동 피로가 커서 차량 2대가 현실적"
      ],
      "attractions": [
        {"name":"강화씨사이드리조트 루지","kind":"activity","description":"서해권 단체 액티비티 후보. 곤돌라와 루지를 함께 이용 가능","sourceUrl":"https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=139945","mapUrl":"https://map.naver.com/p/search/%EA%B0%95%ED%99%94%EC%94%A8%EC%82%AC%EC%9D%B4%EB%93%9C%EB%A6%AC%EC%A1%B0%ED%8A%B8"},
        {"name":"보문사","kind":"view","description":"석모도 대표 사찰과 바다 전망 코스","sourceUrl":"https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=112017","mapUrl":"https://map.kakao.com/?q=%EA%B0%95%ED%99%94%20%EB%B3%B4%EB%AC%B8%EC%82%AC"},
        {"name":"동막해변/갯벌","kind":"mudflat","description":"서해 갯벌과 일몰 산책 후보","sourceUrl":"https://www.ganghwa.go.kr/open_content/english/culture/ganghwa02.jsp","mapUrl":"https://www.google.com/maps/search/?api=1&query=Dongmak+Beach+Ganghwa"},
        {"name":"석모도 미네랄 온천","kind":"rest","description":"숙소 중심 여행에 넣기 좋은 휴식 코스","sourceUrl":"https://english.visitkorea.or.kr/svc/whereToGo/hdrdslt/hdrdsltView.do?crsSn=267","mapUrl":"https://map.naver.com/p/search/%EC%84%9D%EB%AA%A8%EB%8F%84%20%EB%AF%B8%EB%84%A4%EB%9E%84%20%EC%98%A8%EC%B2%9C"}
      ],
      "stays": [
        {"name":"강화도 8인 Airbnb 공개 검색","area":"강화 남부/동막", "notes":"서울권 접근성과 바비큐 숙소 중심 후보. 차량 주차, 침실 수, 바비큐 가능 여부 확인 필요.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EA%B0%95%ED%99%94%EB%8F%84--%EC%9D%B8%EC%B2%9C--%ED%95%9C%EA%B5%AD/homes?adults=8", "sourceUrls":["https://www.ganghwa.go.kr/open_content/english/culture/ganghwa02.jsp"]},
        {"name":"석모도 8인 Airbnb 공개 검색","area":"석모도/삼산면", "notes":"온천과 보문사 동선 후보. 저녁 장보기와 차량 이동 시간 확인 필요.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EC%84%9D%EB%AA%A8%EB%8F%84--%EA%B0%95%ED%99%94--%ED%95%9C%EA%B5%AD/homes?adults=8", "sourceUrls":["https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=112017"]},
        {"name":"동막해변 8인 Airbnb 공개 검색","area":"동막/화도면", "notes":"해변과 갯벌 접근 후보. 성수기 주차와 소음 규정 확인 필요.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EB%8F%99%EB%A7%89%ED%95%B4%EB%B3%80--%EA%B0%95%ED%99%94--%ED%95%9C%EA%B5%AD/homes?adults=8", "sourceUrls":["https://www.ganghwa.go.kr/open_content/english/culture/ganghwa02.jsp"]}
      ],
      "activities": [
        {"name":"루지와 곤돌라","risk":"주말 대기와 운영 시간 확인"},
        {"name":"서해 일몰/갯벌 산책","risk":"물때와 날씨 영향"},
        {"name":"숙소 바비큐와 온천","risk":"숙소 규정과 온천 운영 확인"}
      ]
    }$$::jsonb
  ),
  (
    'boryeong-daecheon',
    'boryeong-daecheon',
    '보령 대천/무창포',
    '충청남도 보령시',
    'major',
    36.309900,
    126.513100,
    '보령',
    '서해 최대급 해변과 머드/짚트랙/스카이바이크를 묶을 수 있는 활동형 후보.',
    '6월 말, 7월 초, 8월 말, 9월 초',
    '2박3일 추천',
    'https://commons.wikimedia.org/wiki/Special:Redirect/file/Korea-Boreyong-Daecheon_Beach-01.jpg',
    'https://commons.wikimedia.org/wiki/File:Korea-Boreyong-Daecheon_Beach-01.jpg',
    'Wikimedia Commons',
    array['기차가능', '서해', '해변', '액티비티', '머드'],
    $${
      "fit": "해변에서 놀고 액티비티까지 넣고 싶은 친구 모임에 맞는 서해 대표 후보",
      "sourceUrls": [
        "https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=105704",
        "https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=74238",
        "https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=191337"
      ],
      "blogEvidenceUrls": [
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EB%B3%B4%EB%A0%B9%20%EB%8C%80%EC%B2%9C%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%20%EC%97%AC%ED%96%89",
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EB%8C%80%EC%B2%9C%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5%208%EC%9D%B8%20%ED%8E%9C%EC%85%98"
      ],
      "reviewThemes": [
        "해변, 짚트랙, 스카이바이크처럼 단체로 할 일이 명확함",
        "무창포 물때 일정은 사전 확인이 필요함",
        "축제/성수기에는 숙소와 해변 혼잡도가 크게 오름"
      ],
      "attractions": [
        {"name":"대천해수욕장","kind":"beach","description":"서해 대표 해변과 머드광장 중심 코스","sourceUrl":"https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=105704","mapUrl":"https://map.naver.com/p/search/%EB%8C%80%EC%B2%9C%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5"},
        {"name":"무창포해수욕장","kind":"sea road","description":"물때가 맞으면 바닷길 체험을 넣을 수 있는 코스","sourceUrl":"https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=74238","mapUrl":"https://map.kakao.com/?q=%EB%AC%B4%EC%B0%BD%ED%8F%AC%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5"},
        {"name":"짚트랙 코리아","kind":"activity","description":"대천해변 위를 지나는 짚라인 액티비티","sourceUrl":"https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=191337","mapUrl":"https://www.google.com/maps/search/?api=1&query=Ziptrek+Korea+Boryeong"},
        {"name":"대천 스카이바이크","kind":"activity","description":"대천해변과 항구를 따라 가는 해안 레일바이크 후보","sourceUrl":"https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=105704","mapUrl":"https://map.naver.com/p/search/%EB%8C%80%EC%B2%9C%20%EC%8A%A4%EC%B9%B4%EC%9D%B4%EB%B0%94%EC%9D%B4%ED%81%AC"}
      ],
      "stays": [
        {"name":"대천해수욕장 8인 Airbnb 공개 검색","area":"대천해수욕장/머드광장", "notes":"해변 접근과 밤 산책이 좋은 권역. 8인 객실 구조, 주차, 엘리베이터 확인 필요.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EB%8C%80%EC%B2%9C%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5--%EB%B3%B4%EB%A0%B9--%ED%95%9C%EA%B5%AD/homes?adults=8", "sourceUrls":["https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=105704"]},
        {"name":"보령 8인 Airbnb 공개 검색","area":"보령시", "notes":"차량 이동 단체 숙소 후보. 해변까지 이동 시간 확인 필요.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EB%B3%B4%EB%A0%B9--%EC%B6%A9%EC%B2%AD%EB%82%A8%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8", "sourceUrls":["https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=74238"]},
        {"name":"무창포 8인 Airbnb 공개 검색","area":"무창포/웅천", "notes":"바닷길과 조용한 해변 중심 후보. 물때와 장보기 동선 확인 필요.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EB%AC%B4%EC%B0%BD%ED%8F%AC--%EB%B3%B4%EB%A0%B9--%ED%95%9C%EA%B5%AD/homes?adults=8", "sourceUrls":["https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=74238"]}
      ],
      "activities": [
        {"name":"대천 해변 물놀이","risk":"성수기 혼잡"},
        {"name":"짚트랙/스카이바이크","risk":"강풍/우천 운영 확인"},
        {"name":"무창포 바닷길","risk":"물때 확인 필수"}
      ]
    }$$::jsonb
  ),
  (
    'gunsan-seonyudo',
    'gunsan-seonyudo',
    '군산 선유도/고군산군도',
    '전북특별자치도 군산시',
    'alternative',
    35.817700,
    126.416600,
    '군산',
    '섬 사이를 다리로 이동하며 해변, 자전거, 전망, 군산 먹거리를 묶을 수 있는 서해 섬 후보.',
    '6월 말, 8월 말, 9월 초',
    '3박4일 추천',
    'https://commons.wikimedia.org/wiki/Special:Redirect/file/Seonyu_island.JPG',
    'https://commons.wikimedia.org/wiki/File:Seonyu_island.JPG',
    'Wikimedia Commons',
    array['렌터카추천', '서해', '섬', '자전거', '대안후보'],
    $${
      "fit": "차량이나 렌터카를 쓰면 서해 섬 여행 감도가 가장 살아나는 후보",
      "sourceUrls": [
        "https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=94264",
        "https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=15047",
        "https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=15076"
      ],
      "blogEvidenceUrls": [
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EA%B5%B0%EC%82%B0%20%EC%84%A0%EC%9C%A0%EB%8F%84%20%EC%97%AC%ED%96%89",
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EC%84%A0%EC%9C%A0%EB%8F%84%208%EC%9D%B8%20%ED%8E%9C%EC%85%98"
      ],
      "reviewThemes": [
        "선유도, 장자도, 무녀도 연결 동선이 섬 여행 느낌을 줌",
        "자전거/도보/전망 코스가 좋아 낮 일정이 풍부함",
        "대중교통만으로는 이동 시간이 길어 익산/군산 렌터카가 현실적"
      ],
      "attractions": [
        {"name":"선유도","kind":"island","description":"고군산군도 중심 섬이자 서해 여름 여행 대표 후보","sourceUrl":"https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=94264","mapUrl":"https://map.naver.com/p/search/%EA%B5%B0%EC%82%B0%20%EC%84%A0%EC%9C%A0%EB%8F%84"},
        {"name":"선유도해수욕장","kind":"beach","description":"수심이 완만한 명사십리 해변 코스","sourceUrl":"https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=15076","mapUrl":"https://map.kakao.com/?q=%EC%84%A0%EC%9C%A0%EB%8F%84%ED%95%B4%EC%88%98%EC%9A%95%EC%9E%A5"},
        {"name":"무녀도/장자도 연결 코스","kind":"walk","description":"다리로 이어진 섬들을 자전거 또는 도보로 연결 가능","sourceUrl":"https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=15047","mapUrl":"https://www.google.com/maps/search/?api=1&query=Munyeodo+Seonyudo+Gunsan"},
        {"name":"장자도 대장봉","kind":"view","description":"고군산군도 전망과 노을 후보","sourceUrl":"https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=15053","mapUrl":"https://map.naver.com/p/search/%EC%9E%A5%EC%9E%90%EB%8F%84%20%EB%8C%80%EC%9E%A5%EB%B4%89"}
      ],
      "stays": [
        {"name":"선유도 8인 Airbnb 공개 검색","area":"선유도/진리", "notes":"섬 안에서 머무는 후보. 식당 마감, 장보기, 주차 위치 확인 필요.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EC%84%A0%EC%9C%A0%EB%8F%84--%EA%B5%B0%EC%82%B0--%ED%95%9C%EA%B5%AD/homes?adults=8", "sourceUrls":["https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=94264"]},
        {"name":"군산 8인 Airbnb 공개 검색","area":"군산 시내", "notes":"군산 먹거리와 선유도 당일 이동을 섞는 후보. 섬까지 차량 이동 시간 확인 필요.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EA%B5%B0%EC%82%B0--%EC%A0%84%EB%9D%BC%EB%B6%81%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8", "sourceUrls":["https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=15047"]},
        {"name":"고군산군도 8인 Airbnb 공개 검색","area":"무녀도/장자도", "notes":"섬 연결 코스 중심 후보. 예약 가능 숙소 수가 적을 수 있어 조기 확인 필요.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EA%B3%A0%EA%B5%B0%EC%82%B0%EA%B5%B0%EB%8F%84--%EA%B5%B0%EC%82%B0--%ED%95%9C%EA%B5%AD/homes?adults=8", "sourceUrls":["https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=15047"]}
      ],
      "activities": [
        {"name":"섬 자전거/도보 이동","risk":"더위와 대여 가능 여부 확인"},
        {"name":"선유도 해변 일정","risk":"성수기 주차와 혼잡"},
        {"name":"군산 먹거리 투어","risk":"섬 숙박 시 밤 이동 제한"}
      ]
    }$$::jsonb
  ),
  (
    'mokpo-sinan-jeungdo',
    'mokpo-sinan-jeungdo',
    '목포/신안 증도',
    '전라남도 목포시/신안군',
    'alternative',
    34.811800,
    126.392200,
    '목포',
    'KTX 목포와 신안 섬을 묶는 남서해 후보. 케이블카, 갓바위, 증도 갯벌/염전을 함께 설계할 수 있다.',
    '6월 말, 8월 말, 9월 초',
    '3박4일 추천',
    'https://commons.wikimedia.org/wiki/Special:Redirect/file/Mokpo_Marine_Cable_Car_in_South_Korea_(at_night).jpg',
    'https://commons.wikimedia.org/wiki/File:Mokpo_Marine_Cable_Car_in_South_Korea_(at_night).jpg',
    'Korea Tourism Organization / Wikimedia Commons',
    array['KTX친화', '서해', '남서해', '케이블카', '갯벌'],
    $${
      "fit": "KTX로 장거리 운전 부담을 줄이고 남서해 도시와 섬 풍경을 섞기 좋은 후보",
      "sourceUrls": [
        "https://english.visitkorea.or.kr/svc/whereToGo/locIntrdn/rgnContentsView.do?vcontsId=60936",
        "https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=81622",
        "https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=93924"
      ],
      "blogEvidenceUrls": [
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EB%AA%A9%ED%8F%AC%20%EC%8B%A0%EC%95%88%20%EC%A6%9D%EB%8F%84%20%EC%97%AC%ED%96%89",
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EB%AA%A9%ED%8F%AC%208%EC%9D%B8%20%EC%88%99%EC%86%8C"
      ],
      "reviewThemes": [
        "목포 시내는 KTX 접근과 야경/먹거리 동선이 좋음",
        "증도는 갯벌, 염전, 슬로시티 분위기가 강해 휴식형 일정에 적합함",
        "증도까지 확장하면 렌터카나 차량 분승이 필요함"
      ],
      "attractions": [
        {"name":"목포 해상케이블카","kind":"view","description":"유달산과 고하도를 잇는 목포 대표 전망 코스","sourceUrl":"https://english.visitkorea.or.kr/svc/whereToGo/locIntrdn/rgnContentsView.do?vcontsId=60936","mapUrl":"https://map.naver.com/p/search/%EB%AA%A9%ED%8F%AC%20%ED%95%B4%EC%83%81%EC%BC%80%EC%9D%B4%EB%B8%94%EC%B9%B4"},
        {"name":"목포 갓바위","kind":"walk","description":"해안 산책로와 자연기념물 코스","sourceUrl":"https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=81622","mapUrl":"https://map.kakao.com/?q=%EB%AA%A9%ED%8F%AC%20%EA%B0%93%EB%B0%94%EC%9C%84"},
        {"name":"증도 짱뚱어다리","kind":"mudflat","description":"갯벌 생태를 가까이 볼 수 있는 목재 다리 코스","sourceUrl":"https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=69600","mapUrl":"https://www.google.com/maps/search/?api=1&query=Jjangttungeo+Bridge+Sinan"},
        {"name":"증도/태평염전","kind":"slow travel","description":"슬로시티 증도의 염전과 갯벌 중심 코스","sourceUrl":"https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=93924","mapUrl":"https://map.naver.com/p/search/%EC%A6%9D%EB%8F%84%20%ED%83%9C%ED%8F%89%EC%97%BC%EC%A0%84"}
      ],
      "stays": [
        {"name":"목포 8인 Airbnb 공개 검색","area":"목포역/평화광장/북항", "notes":"KTX 도착과 야경, 먹거리 접근 후보. 8인은 객실 구조와 주차 확인 필요.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EB%AA%A9%ED%8F%AC--%EC%A0%84%EB%9D%BC%EB%82%A8%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8", "sourceUrls":["https://english.visitkorea.or.kr/svc/whereToGo/locIntrdn/rgnContentsView.do?vcontsId=74267"]},
        {"name":"신안 8인 Airbnb 공개 검색","area":"신안/증도", "notes":"섬 휴식형 숙소 후보. 렌터카 이동, 식당 운영, 장보기 동선 확인 필요.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EC%8B%A0%EC%95%88--%EC%A0%84%EB%9D%BC%EB%82%A8%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8", "sourceUrls":["https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=93924"]},
        {"name":"증도 8인 Airbnb 공개 검색","area":"증도/우전해변", "notes":"갯벌과 해변 중심 후보. 숙소 수가 적을 수 있어 날짜별 확인 필요.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EC%A6%9D%EB%8F%84--%EC%8B%A0%EC%95%88--%ED%95%9C%EA%B5%AD/homes?adults=8", "sourceUrls":["https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=93924"]}
      ],
      "activities": [
        {"name":"목포 해상케이블카 야경","risk":"강풍과 운영 시간 확인"},
        {"name":"목포 해산물/시장 투어","risk":"예산 개인차"},
        {"name":"증도 갯벌/염전 코스","risk":"차량 이동과 물때 확인"}
      ]
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
  ('ganghwa-car-only', 'ganghwa-seokmodo', 'car_only', '차량 직행', '["잠실 출발", "올림픽대로/수도권제1순환", "강화도 또는 석모도 숙소 도착"]'::jsonb, '약 1.5-2.5시간', '유류/통행료+주차, 렌트 시 중간', true, false, '주말 강화대교/초지대교 정체와 숙소 주차 확인', 10),
  ('ganghwa-bus-local', 'ganghwa-seokmodo', 'ktx_local', '광역버스 + 택시', '["잠실에서 김포/홍대입구권 이동", "강화행 버스", "현지 택시 또는 분승 이동"]'::jsonb, '약 2.5-4시간', '저렴하지만 택시 분승 비용 발생', false, false, '8명 짐 이동과 배차 대기 때문에 차량 대비 피로도 높음', 20),
  ('ganghwa-rental', 'ganghwa-seokmodo', 'ktx_rental', '김포/인천 렌터카', '["잠실에서 김포/인천 이동", "렌터카 픽업", "강화/석모도 이동"]'::jsonb, '약 2-3시간', '렌터카+주차로 중상', true, true, '픽업/반납 위치와 주말 정체 확인', 30),
  ('boryeong-train-local', 'boryeong-daecheon', 'ktx_local', '장항선 열차 + 택시', '["잠실에서 용산역 이동", "장항선 열차로 대천역", "택시로 대천해수욕장 이동"]'::jsonb, '약 3-4시간', '열차+택시 1인 중간', false, false, '성수기 열차 좌석과 대천역 택시 대기 확인', 10),
  ('boryeong-car-only', 'boryeong-daecheon', 'car_only', '차량 직행', '["잠실 출발", "서해안고속도로", "대천/무창포 숙소 도착"]'::jsonb, '약 2.5-4시간', '유류/통행료+주차+렌트 시 중상', true, false, '해수욕장 주차와 음주 후 운전 분담 필요', 20),
  ('boryeong-rental', 'boryeong-daecheon', 'ktx_rental', '천안아산/대천 렌터카', '["열차로 천안아산 또는 대천권 이동", "렌터카 픽업", "무창포/대천 확장"]'::jsonb, '약 3.5-4.5시간', '열차+렌터카로 높음', true, true, '대천역 렌터카 수량과 반납 시간을 미리 확인', 30),
  ('gunsan-ktx-rental', 'gunsan-seonyudo', 'ktx_rental', 'KTX 익산 + 렌터카', '["잠실에서 용산/수서 이동", "KTX로 익산", "렌터카로 군산/선유도 이동"]'::jsonb, '약 3.5-5시간', '열차+렌터카로 높음', true, true, '익산 렌터카 픽업과 섬 주차 위치 확인', 10),
  ('gunsan-car-only', 'gunsan-seonyudo', 'car_only', '차량 직행', '["잠실 출발", "서해안고속도로/새만금 방면", "선유도 또는 군산 숙소 도착"]'::jsonb, '약 3.5-5.5시간', '유류/통행료+주차+렌트 시 중상', true, false, '새만금/섬 진입 도로와 주말 정체 확인', 20),
  ('gunsan-train-local', 'gunsan-seonyudo', 'ktx_local', '열차 + 현지 버스/택시', '["열차로 군산 또는 익산", "군산 시내 이동", "선유도행 버스/택시"]'::jsonb, '약 4.5-6시간', '교통비는 중간이나 택시 분승 변수', false, false, '8명 단체와 짐이 있으면 대기 시간이 큼', 30),
  ('mokpo-ktx-local', 'mokpo-sinan-jeungdo', 'ktx_local', 'KTX + 목포 택시', '["잠실에서 용산/수서 이동", "KTX로 목포역", "택시로 북항/평화광장/케이블카 이동"]'::jsonb, '약 3.5-4.5시간', '왕복 열차+택시 1인 중상', false, false, '증도까지 확장하지 않는 목포 중심 일정에 적합', 10),
  ('mokpo-ktx-rental', 'mokpo-sinan-jeungdo', 'ktx_rental', 'KTX 목포 + 렌터카', '["KTX 목포역 도착", "렌터카 픽업", "증도/신안 섬 코스 확장"]'::jsonb, '약 4.5-6시간', '열차+렌터카로 높음', true, true, '증도 왕복 이동과 야간 운전 피로 확인', 20),
  ('mokpo-car-only', 'mokpo-sinan-jeungdo', 'car_only', '차량 직행', '["잠실 출발", "서해안고속도로", "목포/신안 숙소 도착"]'::jsonb, '약 4.5-6.5시간', '유류/통행료+주차+렌트 시 높음', true, false, '장거리 운전 부담이 커서 운전자 분담 필요', 30)
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
