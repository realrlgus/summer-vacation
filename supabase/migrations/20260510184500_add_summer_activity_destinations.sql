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
    'gapyeong-cheongpyeong-water',
    'gapyeong-cheongpyeong-water',
    '가평 청평호/빠지',
    '경기도 가평군',
    'alternative',
    37.716900,
    127.489900,
    '가평',
    '서울에서 가까운 여름 수상레저 후보. 빠지, 웨이크보드, 바나나보트, 계곡과 단체 펜션을 묶기 좋다.',
    '6월 말, 7월, 8월, 9월 초',
    '2박3일 최적',
    'https://commons.wikimedia.org/wiki/Special:Redirect/file/Chungpyeong_lake_on_August_4th,_2018.jpg',
    'https://commons.wikimedia.org/wiki/File:Chungpyeong_lake_on_August_4th,_2018.jpg',
    'Choi2451 / Wikimedia Commons',
    array['근교', '수상레저', '빠지', '계곡', '차량권장'],
    $${
      "fit": "멀리 가기 부담스러운데 물놀이와 숙소 바비큐를 확실히 하고 싶은 팀에 맞음",
      "sourceUrls": [
        "https://www.gptour.go.kr/tour/tour_view.jsp?menu=tour&paramidx=TL0000094&submenu=main",
        "https://commons.wikimedia.org/wiki/File:Chungpyeong_lake_on_August_4th,_2018.jpg"
      ],
      "blogEvidenceUrls": [
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EA%B0%80%ED%8F%89%20%EB%B9%A0%EC%A7%80%20%EC%97%AC%ED%96%89",
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EA%B0%80%ED%8F%89%208%EC%9D%B8%20%ED%8E%9C%EC%85%98"
      ],
      "reviewThemes": [
        "청평호 수상레저 업체가 많아 단체 물놀이 일정 짜기 쉬움",
        "서울권에서 가까워 금요일 퇴근 후 출발 부담이 낮음",
        "성수기 도로 정체와 숙소 소음/바비큐 규정 확인 필요"
      ],
      "attractions": [
        {"name":"청평호 수상레저","kind":"water sports","description":"수상스키, 웨이크보드, 바나나보트 등 단체 물놀이 후보","sourceUrl":"https://www.gptour.go.kr/tour/tour_view.jsp?menu=tour&paramidx=TL0000094&submenu=main","mapUrl":"https://map.naver.com/p/search/%EA%B0%80%ED%8F%89%20%EC%B2%AD%ED%8F%89%ED%98%B8%20%EC%88%98%EC%83%81%EB%A0%88%EC%A0%80","imageUrl":"https://commons.wikimedia.org/wiki/Special:Redirect/file/Chungpyeong_lake_on_August_4th,_2018.jpg","imageSourceUrl":"https://commons.wikimedia.org/wiki/File:Chungpyeong_lake_on_August_4th,_2018.jpg"},
        {"name":"어비계곡","kind":"valley","description":"물놀이 뒤 짧게 넣을 수 있는 계곡 후보","sourceUrl":"https://www.gptour.go.kr/","mapUrl":"https://map.kakao.com/?q=%EA%B0%80%ED%8F%89%20%EC%96%B4%EB%B9%84%EA%B3%84%EA%B3%A1"},
        {"name":"아침고요수목원","kind":"walk","description":"물놀이가 어려운 날 대체 가능한 산책 코스","sourceUrl":"https://www.gptour.go.kr/","mapUrl":"https://www.google.com/maps/search/?api=1&query=Garden+of+Morning+Calm"},
        {"name":"남이섬","kind":"classic","description":"가평권 대표 관광지. 비 예보가 있을 때 대체 코스로 고려","sourceUrl":"https://www.gptour.go.kr/","mapUrl":"https://map.naver.com/p/search/%EB%82%A8%EC%9D%B4%EC%84%AC"}
      ],
      "stays": [
        {"name":"가평 8인 Airbnb 공개 검색","area":"청평/설악/가평읍", "notes":"빠지 픽업, 바비큐, 방 개수, 주차 확인 필요.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EA%B0%80%ED%8F%89--%EA%B2%BD%EA%B8%B0%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28", "sourceUrls":["https://www.gptour.go.kr/"]},
        {"name":"청평호 8인 Airbnb 공개 검색","area":"청평호/설악면", "notes":"수상레저 업체 접근이 좋은 후보. 퇴실 시간과 픽업 가능 여부 확인.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EC%B2%AD%ED%8F%89%ED%98%B8--%EA%B0%80%ED%8F%89--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28"}
      ],
      "activities": [
        {"name":"빠지 무제한 패키지","risk":"우천/강풍 시 운영 확인", "imageUrl":"https://commons.wikimedia.org/wiki/Special:Redirect/file/Chungpyeong_lake_on_August_4th,_2018.jpg","imageSourceUrl":"https://commons.wikimedia.org/wiki/File:Chungpyeong_lake_on_August_4th,_2018.jpg"},
        {"name":"웨이크보드 강습","risk":"초보자 체력 소모 큼"},
        {"name":"계곡 물놀이와 숙소 바비큐","risk":"성수기 소음 규정 확인"}
      ]
    }$$::jsonb
  ),
  (
    'inje-naerincheon-rafting',
    'inje-naerincheon-rafting',
    '인제 내린천 래프팅',
    '강원특별자치도 인제군',
    'alternative',
    38.070400,
    128.170900,
    '인제',
    '급류 래프팅, 짚트랙, ATV를 묶는 강원도 액티비티 후보. 물놀이 강도는 가장 높다.',
    '6월 말, 7월, 8월',
    '2박3일 또는 3박4일',
    'https://commons.wikimedia.org/wiki/Special:Redirect/file/Gombaeryeong.jpg',
    'https://commons.wikimedia.org/wiki/File:Gombaeryeong.jpg',
    'Wikimedia Commons',
    array['래프팅', '계곡', '강원', '액티비티', '차량권장'],
    $${
      "fit": "물놀이를 조용히 보는 여행보다 직접 젖고 노는 액티비티형 팀에 적합",
      "sourceUrls": [
        "https://russian.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=90563",
        "https://www.yna.co.kr/view/AKR20240627157200062",
        "https://commons.wikimedia.org/wiki/File:Gombaeryeong.jpg"
      ],
      "blogEvidenceUrls": [
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EC%9D%B8%EC%A0%9C%20%EB%82%B4%EB%A6%B0%EC%B2%9C%20%EB%9E%98%ED%94%84%ED%8C%85",
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EC%9D%B8%EC%A0%9C%208%EC%9D%B8%20%ED%8E%9C%EC%85%98"
      ],
      "reviewThemes": [
        "내린천은 여름 래프팅 명소로 알려져 있어 액티비티 목적이 선명함",
        "비가 온 뒤 수량과 운영 여부가 변수가 될 수 있음",
        "숙소와 래프팅 업체 픽업 위치를 같이 맞추는 것이 중요함"
      ],
      "attractions": [
        {"name":"내린천 래프팅","kind":"rafting","description":"급류 기반의 대표 여름 액티비티","sourceUrl":"https://russian.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=90563","mapUrl":"https://map.naver.com/p/search/%EC%9D%B8%EC%A0%9C%20%EB%82%B4%EB%A6%B0%EC%B2%9C%20%EB%9E%98%ED%94%84%ED%8C%85","imageUrl":"https://commons.wikimedia.org/wiki/Special:Redirect/file/Gombaeryeong.jpg","imageSourceUrl":"https://commons.wikimedia.org/wiki/File:Gombaeryeong.jpg"},
        {"name":"엑스게임리조트/번지점프 권역","kind":"extreme","description":"짚트랙, 번지, ATV 같은 고강도 액티비티 후보","sourceUrl":"https://www.tripinfo.co.kr/info.html?content_id=131806&content_type_id=28","mapUrl":"https://map.kakao.com/?q=%EC%9D%B8%EC%A0%9C%20%EC%97%91%EC%8A%A4%EA%B2%8C%EC%9E%84%EB%A6%AC%EC%A1%B0%ED%8A%B8"},
        {"name":"원대리 자작나무숲","kind":"forest","description":"물놀이 다음날 회복 산책 코스","sourceUrl":"https://www.inje.go.kr/tour","mapUrl":"https://www.google.com/maps/search/?api=1&query=Inje+Wondae-ri+Birch+Forest"},
        {"name":"방태산 계곡권","kind":"valley","description":"차량 이동으로 확장 가능한 계곡 후보","sourceUrl":"https://www.inje.go.kr/tour","mapUrl":"https://map.naver.com/p/search/%EB%B0%A9%ED%83%9C%EC%82%B0%20%EA%B3%84%EA%B3%A1"}
      ],
      "stays": [
        {"name":"인제 8인 Airbnb 공개 검색","area":"인제읍/기린면", "notes":"래프팅 업체 픽업 가능 여부와 샤워/건조 동선 확인.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EC%9D%B8%EC%A0%9C--%EA%B0%95%EC%9B%90%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28"},
        {"name":"내린천 8인 Airbnb 공개 검색","area":"내린천/기린면", "notes":"강변 펜션형 후보. 성수기 조기 예약 필요.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EB%82%B4%EB%A6%B0%EC%B2%9C--%EC%9D%B8%EC%A0%9C--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28"}
      ],
      "activities": [
        {"name":"내린천 래프팅","risk":"수량, 우천, 안전교육 필수", "imageUrl":"https://commons.wikimedia.org/wiki/Special:Redirect/file/Gombaeryeong.jpg","imageSourceUrl":"https://commons.wikimedia.org/wiki/File:Gombaeryeong.jpg"},
        {"name":"짚트랙/ATV","risk":"현장 운영과 보험 확인"},
        {"name":"자작나무숲 회복 산책","risk":"날씨와 입산 통제 확인"}
      ]
    }$$::jsonb
  ),
  (
    'danyang-adventure',
    'danyang-adventure',
    '단양 패러글라이딩/남한강',
    '충청북도 단양군',
    'alternative',
    36.984600,
    128.365500,
    '단양',
    '패러글라이딩, 만천하스카이워크, 남한강 잔도와 동굴을 묶는 산/강 액티비티 후보.',
    '6월 말, 7월, 8월, 9월 초',
    '2박3일 또는 3박4일',
    'https://commons.wikimedia.org/wiki/Special:Redirect/file/Danyang_Travel_Day1_01_(31514871834).jpg',
    'https://commons.wikimedia.org/wiki/File:Danyang_Travel_Day1_01_(31514871834).jpg',
    'Korea.net / Wikimedia Commons',
    array['패러글라이딩', '강', '스카이워크', '동굴', 'KTX가능'],
    $${
      "fit": "물놀이보다 하늘/전망/걷기 액티비티를 섞고 싶은 팀에 적합",
      "sourceUrls": [
        "https://korean.visitkorea.or.kr/detail/rem_detail.do?cotid=f97b1d50-6ec7-469b-8891-501e3733bb8e",
        "https://korean.visitkorea.or.kr/dgtourcard/biz/mbrb/mbrbPtcl.do?mbrbId=e8db9a60-84ae-4363-ba4b-1bedbfcaff04",
        "https://commons.wikimedia.org/wiki/File:Danyang_Travel_Day1_01_(31514871834).jpg"
      ],
      "blogEvidenceUrls": [
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EB%8B%A8%EC%96%91%20%ED%8C%A8%EB%9F%AC%EA%B8%80%EB%9D%BC%EC%9D%B4%EB%94%A9%20%EC%97%AC%ED%96%89",
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EB%8B%A8%EC%96%91%208%EC%9D%B8%20%EC%88%99%EC%86%8C"
      ],
      "reviewThemes": [
        "패러글라이딩과 만천하스카이워크가 대표 체험 포인트",
        "비/강풍이면 하늘 액티비티가 취소될 수 있어 대체 코스가 필요함",
        "단양읍 숙박이면 식당과 강변 동선이 편함"
      ],
      "attractions": [
        {"name":"단양 패러글라이딩","kind":"air sports","description":"남한강과 산지를 내려다보는 대표 액티비티","sourceUrl":"https://korean.visitkorea.or.kr/dgtourcard/biz/mbrb/mbrbPtcl.do?mbrbId=e8db9a60-84ae-4363-ba4b-1bedbfcaff04","mapUrl":"https://map.naver.com/p/search/%EB%8B%A8%EC%96%91%20%ED%8C%A8%EB%9F%AC%EA%B8%80%EB%9D%BC%EC%9D%B4%EB%94%A9","imageUrl":"https://commons.wikimedia.org/wiki/Special:Redirect/file/Danyang_Travel_Day1_01_(31514871834).jpg","imageSourceUrl":"https://commons.wikimedia.org/wiki/File:Danyang_Travel_Day1_01_(31514871834).jpg"},
        {"name":"만천하스카이워크","kind":"view","description":"짚와이어/알파인코스터까지 확장 가능한 전망형 테마파크","sourceUrl":"https://korean.visitkorea.or.kr/detail/rem_detail.do?cotid=f97b1d50-6ec7-469b-8891-501e3733bb8e","mapUrl":"https://map.kakao.com/?q=%EB%8B%A8%EC%96%91%20%EB%A7%8C%EC%B2%9C%ED%95%98%EC%8A%A4%EC%B9%B4%EC%9D%B4%EC%9B%8C%ED%81%AC"},
        {"name":"고수동굴","kind":"cave","description":"비가 오거나 더울 때 넣기 좋은 실내/동굴 코스","sourceUrl":"https://commons.wikimedia.org/wiki/File:Korea-Danyang-Gosu_Cave_3187-07.JPG","mapUrl":"https://www.google.com/maps/search/?api=1&query=Gosu+Cave+Danyang","imageUrl":"https://commons.wikimedia.org/wiki/Special:Redirect/file/Korea-Danyang-Gosu_Cave_3187-07.JPG","imageSourceUrl":"https://commons.wikimedia.org/wiki/File:Korea-Danyang-Gosu_Cave_3187-07.JPG"},
        {"name":"단양강 잔도","kind":"walk","description":"남한강을 따라 걷는 짧은 산책 코스","sourceUrl":"https://korean.visitkorea.or.kr/detail/rem_detail.do?cotid=f97b1d50-6ec7-469b-8891-501e3733bb8e","mapUrl":"https://map.naver.com/p/search/%EB%8B%A8%EC%96%91%EA%B0%95%20%EC%9E%94%EB%8F%84"}
      ],
      "stays": [
        {"name":"단양 8인 Airbnb 공개 검색","area":"단양읍/남한강변", "notes":"패러글라이딩 픽업, 방 개수, 주차 확인.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EB%8B%A8%EC%96%91--%EC%B6%A9%EC%B2%AD%EB%B6%81%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28"},
        {"name":"단양 펜션형 8인 숙소 검색","area":"가곡/영춘/단양읍", "notes":"차량 이동 전제 숙소 후보. 장보기와 식당 거리 확인.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EB%8B%A8%EC%96%91%EA%B5%B0--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28"}
      ],
      "activities": [
        {"name":"패러글라이딩","risk":"강풍/우천 취소 가능", "imageUrl":"https://commons.wikimedia.org/wiki/Special:Redirect/file/Danyang_Travel_Day1_01_(31514871834).jpg","imageSourceUrl":"https://commons.wikimedia.org/wiki/File:Danyang_Travel_Day1_01_(31514871834).jpg"},
        {"name":"짚와이어/알파인코스터","risk":"운영 시간과 대기 확인"},
        {"name":"고수동굴 피난 코스","risk":"성수기 대기"}
      ]
    }$$::jsonb
  ),
  (
    'muju-gucheondong-valley',
    'muju-gucheondong-valley',
    '무주 구천동/덕유산',
    '전북특별자치도 무주군',
    'alternative',
    35.904200,
    127.752200,
    '무주',
    '계곡 물놀이, 덕유산 숲, 리조트 액티비티를 묶는 내륙 여름 후보. 휴식형과 활동형을 같이 잡는다.',
    '6월 말, 7월, 8월, 9월 초',
    '3박4일 추천, 2박3일 가능',
    'https://commons.wikimedia.org/wiki/Special:Redirect/file/Mujugun_County_33_(16834249346).jpg',
    'https://commons.wikimedia.org/wiki/File:Mujugun_County_33_(16834249346).jpg',
    'Korea.net / Wikimedia Commons',
    array['계곡', '덕유산', '리조트', '내륙휴식', '차량권장'],
    $${
      "fit": "바다 대신 계곡과 산에서 쉬면서 리조트형 액티비티를 넣고 싶은 팀에 적합",
      "sourceUrls": [
        "https://encykorea.aks.ac.kr/Article/E0019248",
        "https://encykorea.aks.ac.kr/Article/E0019249",
        "https://commons.wikimedia.org/wiki/File:Mujugun_County_33_(16834249346).jpg"
      ],
      "blogEvidenceUrls": [
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EB%AC%B4%EC%A3%BC%20%EA%B5%AC%EC%B2%9C%EB%8F%99%20%EA%B3%84%EA%B3%A1%20%EC%97%AC%ED%96%89",
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EB%AC%B4%EC%A3%BC%208%EC%9D%B8%20%ED%8E%9C%EC%85%98"
      ],
      "reviewThemes": [
        "구천동 계곡과 덕유산 숲은 한여름 더위 피하기 좋음",
        "차량이 있어야 숙소, 계곡, 리조트 동선이 편함",
        "물놀이 강도는 래프팅권보다 낮고 휴식 비중이 큼"
      ],
      "attractions": [
        {"name":"무주구천동 계곡","kind":"valley","description":"덕유산권 대표 계곡 산책/물놀이 후보","sourceUrl":"https://encykorea.aks.ac.kr/Article/E0019248","mapUrl":"https://map.naver.com/p/search/%EB%AC%B4%EC%A3%BC%EA%B5%AC%EC%B2%9C%EB%8F%99%20%EA%B3%84%EA%B3%A1","imageUrl":"https://commons.wikimedia.org/wiki/Special:Redirect/file/Mujugun_County_33_(16834249346).jpg","imageSourceUrl":"https://commons.wikimedia.org/wiki/File:Mujugun_County_33_(16834249346).jpg"},
        {"name":"덕유산 리조트권","kind":"resort","description":"곤돌라, 산책, 숙소형 휴식 동선 후보","sourceUrl":"https://encykorea.aks.ac.kr/Article/E0019249","mapUrl":"https://map.kakao.com/?q=%EB%8D%95%EC%9C%A0%EC%82%B0%EB%A6%AC%EC%A1%B0%ED%8A%B8"},
        {"name":"반디랜드","kind":"night","description":"가벼운 실내/야간 대체 코스","sourceUrl":"https://www.muju.go.kr/tour","mapUrl":"https://www.google.com/maps/search/?api=1&query=Muju+Bandi+Land"},
        {"name":"적상산 전망권","kind":"view","description":"차량 드라이브와 전망 후보","sourceUrl":"https://www.muju.go.kr/tour","mapUrl":"https://map.naver.com/p/search/%EB%AC%B4%EC%A3%BC%20%EC%A0%81%EC%83%81%EC%82%B0"}
      ],
      "stays": [
        {"name":"무주 8인 Airbnb 공개 검색","area":"설천/구천동/무주읍", "notes":"계곡 접근, 바비큐, 방 개수, 주차 확인.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EB%AC%B4%EC%A3%BC--%EC%A0%84%EB%9D%BC%EB%B6%81%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28"},
        {"name":"덕유산 8인 숙소 검색","area":"덕유산/설천면", "notes":"리조트와 계곡을 같이 쓰는 숙소 후보.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EB%8D%95%EC%9C%A0%EC%82%B0--%EB%AC%B4%EC%A3%BC--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28"}
      ],
      "activities": [
        {"name":"구천동 계곡 물놀이","risk":"우천 뒤 수량과 안전 확인", "imageUrl":"https://commons.wikimedia.org/wiki/Special:Redirect/file/Mujugun_County_33_(16834249346).jpg","imageSourceUrl":"https://commons.wikimedia.org/wiki/File:Mujugun_County_33_(16834249346).jpg"},
        {"name":"덕유산 곤돌라/산책","risk":"운영 시간과 기상 확인"},
        {"name":"숙소 바비큐와 리조트 휴식","risk":"숙소 규정 확인"}
      ]
    }$$::jsonb
  ),
  (
    'yeongwol-donggang-rafting',
    'yeongwol-donggang-rafting',
    '영월 동강 래프팅',
    '강원특별자치도 영월군',
    'alternative',
    37.183400,
    128.461200,
    '영월',
    '동강 래프팅, 한반도지형, 별마로천문대를 묶는 강원 내륙 액티비티 후보.',
    '6월 말, 7월, 8월, 9월 초',
    '2박3일 또는 3박4일',
    'https://commons.wikimedia.org/wiki/Special:Redirect/file/Dong-gang(river)_flows_near_by_Yeongwol_03.jpg',
    'https://commons.wikimedia.org/wiki/File:Dong-gang(river)_flows_near_by_Yeongwol_03.jpg',
    'Jjw / Wikimedia Commons',
    array['래프팅', '강', '별보기', '강원', '렌터카추천'],
    $${
      "fit": "래프팅과 밤 별보기까지 넣어 액티비티 색이 분명한 내륙 여행을 만들기 좋음",
      "sourceUrls": [
        "https://www.yw.go.kr/tour/selectTourCntntsWebView.do?ctgry=2&key=560&pageUnit=9&searchCnd=all&tourNo=635",
        "https://commons.wikimedia.org/wiki/File:Dong-gang(river)_flows_near_by_Yeongwol_03.jpg"
      ],
      "blogEvidenceUrls": [
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EC%98%81%EC%9B%94%20%EB%8F%99%EA%B0%95%20%EB%9E%98%ED%94%84%ED%8C%85",
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EC%98%81%EC%9B%94%208%EC%9D%B8%20%ED%8E%9C%EC%85%98"
      ],
      "reviewThemes": [
        "동강 래프팅은 급류와 풍경을 같이 잡는 여름 액티비티",
        "별마로천문대와 한반도지형으로 비물놀이 대체 코스를 만들기 쉬움",
        "KTX 제천/영월 접근 후 렌터카 또는 차량 이동이 편함"
      ],
      "attractions": [
        {"name":"동강 래프팅","kind":"rafting","description":"영월 대표 여름 강 액티비티","sourceUrl":"https://www.yw.go.kr/tour/selectTourCntntsWebView.do?ctgry=2&key=560&pageUnit=9&searchCnd=all&tourNo=635","mapUrl":"https://map.naver.com/p/search/%EC%98%81%EC%9B%94%20%EB%8F%99%EA%B0%95%20%EB%9E%98%ED%94%84%ED%8C%85","imageUrl":"https://commons.wikimedia.org/wiki/Special:Redirect/file/Dong-gang(river)_flows_near_by_Yeongwol_03.jpg","imageSourceUrl":"https://commons.wikimedia.org/wiki/File:Dong-gang(river)_flows_near_by_Yeongwol_03.jpg"},
        {"name":"한반도지형","kind":"view","description":"영월 대표 전망 코스","sourceUrl":"https://commons.wikimedia.org/wiki/File:KOCIS_Hanbando-myeon,_Yeongwol-gun,_Gangwon_Province_(4618109268).jpg","mapUrl":"https://map.kakao.com/?q=%EC%98%81%EC%9B%94%20%ED%95%9C%EB%B0%98%EB%8F%84%EC%A7%80%ED%98%95","imageUrl":"https://commons.wikimedia.org/wiki/Special:Redirect/file/KOCIS_Hanbando-myeon,_Yeongwol-gun,_Gangwon_Province_(4618109268).jpg","imageSourceUrl":"https://commons.wikimedia.org/wiki/File:KOCIS_Hanbando-myeon,_Yeongwol-gun,_Gangwon_Province_(4618109268).jpg"},
        {"name":"별마로천문대","kind":"night","description":"날씨가 좋으면 밤 일정으로 강한 후보","sourceUrl":"https://www.yw.go.kr/tour","mapUrl":"https://www.google.com/maps/search/?api=1&query=Byeolmaro+Observatory"},
        {"name":"고씨굴","kind":"cave","description":"비나 더위에 대응하는 동굴 코스","sourceUrl":"https://www.yw.go.kr/tour","mapUrl":"https://map.naver.com/p/search/%EC%98%81%EC%9B%94%20%EA%B3%A0%EC%94%A8%EA%B5%B4"}
      ],
      "stays": [
        {"name":"영월 8인 Airbnb 공개 검색","area":"영월읍/동강권", "notes":"래프팅 업체 접근, 샤워/건조 동선, 주차 확인.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EC%98%81%EC%9B%94--%EA%B0%95%EC%9B%90%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28"},
        {"name":"동강 8인 숙소 검색","area":"동강/삼옥리", "notes":"강변 펜션형 후보. 래프팅 집결지와 이동 거리 확인.", "airbnbUrl":"https://www.airbnb.co.kr/s/%EB%8F%99%EA%B0%95--%EC%98%81%EC%9B%94--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28"}
      ],
      "activities": [
        {"name":"동강 래프팅","risk":"수량, 안전교육, 음주 금지", "imageUrl":"https://commons.wikimedia.org/wiki/Special:Redirect/file/Dong-gang(river)_flows_near_by_Yeongwol_03.jpg","imageSourceUrl":"https://commons.wikimedia.org/wiki/File:Dong-gang(river)_flows_near_by_Yeongwol_03.jpg"},
        {"name":"별마로천문대 야간 일정","risk":"구름/비 예보 확인"},
        {"name":"한반도지형 전망 산책","risk":"더위와 주차 혼잡"}
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
  ('gapyeong-car-only', 'gapyeong-cheongpyeong-water', 'car_only', '차량 직행', '["잠실 출발", "서울양양고속도로/46번 국도", "청평호 또는 가평 숙소 도착"]'::jsonb, '약 1.5-2.5시간', '유류/주차+렌트 시 중간', true, false, '금요일 저녁과 일요일 복귀 정체 확인', 10),
  ('gapyeong-itx-local', 'gapyeong-cheongpyeong-water', 'ktx_local', 'ITX/전철 + 픽업', '["잠실에서 상봉/청량리 이동", "ITX 또는 경춘선", "업체 픽업 또는 택시"]'::jsonb, '약 2-3.5시간', '저렴하지만 픽업 의존', false, false, '8명 짐 이동과 빠지 픽업 가능 여부 확인', 20),
  ('inje-car-only', 'inje-naerincheon-rafting', 'car_only', '차량 직행', '["잠실 출발", "서울양양고속도로", "인제/내린천 숙소 도착"]'::jsonb, '약 2.5-4시간', '유류/통행료+렌트 시 중상', true, false, '래프팅 후 운전 피로와 음주 일정 분리 필요', 10),
  ('inje-bus-rental', 'inje-naerincheon-rafting', 'ktx_rental', '춘천/속초권 렌터카', '["잠실에서 춘천/속초권 이동", "렌터카 픽업", "내린천 이동"]'::jsonb, '약 3.5-5시간', '렌터카+현지 이동으로 높음', true, true, '픽업/반납 시간이 일정 제약이 될 수 있음', 20),
  ('danyang-train-local', 'danyang-adventure', 'ktx_local', 'KTX/무궁화 + 택시', '["잠실에서 청량리/서울역 이동", "제천/단양역 이동", "택시 또는 픽업"]'::jsonb, '약 2.5-4시간', '열차+택시 1인 중간', false, false, '패러글라이딩 픽업 가능 여부 확인', 10),
  ('danyang-car-only', 'danyang-adventure', 'car_only', '차량 직행', '["잠실 출발", "중앙고속도로/평택제천고속도로", "단양 숙소 도착"]'::jsonb, '약 2.5-4시간', '유류/통행료+렌트 시 중상', true, false, '만천하/활공장 이동은 차량이 편함', 20),
  ('muju-car-only', 'muju-gucheondong-valley', 'car_only', '차량 직행', '["잠실 출발", "경부/통영대전고속도로", "무주 구천동 숙소 도착"]'::jsonb, '약 3-5시간', '유류/통행료+렌트 시 중상', true, false, '장거리 운전 분담과 계곡 주차 확인', 10),
  ('muju-train-rental', 'muju-gucheondong-valley', 'ktx_rental', 'KTX 대전/영동 + 렌터카', '["KTX로 대전 또는 영동권 이동", "렌터카 픽업", "무주 이동"]'::jsonb, '약 4-5.5시간', '열차+렌터카로 높음', true, true, '무주 내부 이동은 차량 의존도가 높음', 20),
  ('yeongwol-train-rental', 'yeongwol-donggang-rafting', 'ktx_rental', 'KTX 제천 + 렌터카', '["잠실에서 청량리/서울역 이동", "제천역 이동", "렌터카로 영월/동강 이동"]'::jsonb, '약 3-4.5시간', '열차+렌터카로 중상', true, true, '래프팅 집결지와 숙소 간 거리 확인', 10),
  ('yeongwol-car-only', 'yeongwol-donggang-rafting', 'car_only', '차량 직행', '["잠실 출발", "영동/중앙고속도로", "영월 숙소 도착"]'::jsonb, '약 2.5-4시간', '유류/통행료+렌트 시 중상', true, false, '동강 일대 주차와 야간 운전 확인', 20)
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
    ('gapyeong-cheongpyeong-water', 'https://www.airbnb.co.kr/s/%EA%B0%80%ED%8F%89--%EA%B2%BD%EA%B8%B0%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28', 650000, 1500000, '가평/청평 8인 펜션 2박. 바비큐, 수영장, 픽업 여부에 따라 변동.', 160000, 360000, 'ITX/전철 또는 차량 이동', 'ITX/전철+택시 또는 차량 분승 예상 범위.', 450000, 950000, '쏘카/렌터카 2대 옵션', '차량 직행 시 2박3일 차량 2대, 보험, 유류, 주차 포함 예상.', 320000, 650000, '빠지/수상레저', '8명 수상레저 패키지와 현지 이동 버퍼.'),
    ('inje-naerincheon-rafting', 'https://www.airbnb.co.kr/s/%EC%9D%B8%EC%A0%9C--%EA%B0%95%EC%9B%90%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28', 650000, 1450000, '인제/내린천 8인 펜션 2박. 래프팅 업체 픽업과 샤워 동선 확인.', 0, 0, 'KTX 없음', '잠실 기준 차량 직행 또는 버스+렌터카가 현실적인 후보.', 650000, 1250000, '쏘카/렌터카 2대', '2박3일 차량 2대, 보험, 유류, 통행료 포함 예상.', 360000, 800000, '래프팅/짚트랙', '8명 래프팅, 장비, 추가 액티비티 버퍼.'),
    ('danyang-adventure', 'https://www.airbnb.co.kr/s/%EB%8B%A8%EC%96%91--%EC%B6%A9%EC%B2%AD%EB%B6%81%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28', 650000, 1400000, '단양 8인 숙소 2박. 단양읍/강변권은 주차와 객실 구조 확인.', 320000, 620000, '열차 + 택시', '제천/단양권 열차 왕복과 택시/픽업 예상.', 250000, 700000, '현지 렌터카 옵션', '활공장, 만천하, 동굴을 모두 묶으면 차량 권장.', 600000, 1200000, '패러글라이딩/스카이워크', '패러글라이딩 8명 기준 비용 편차가 커서 넓게 산정.'),
    ('muju-gucheondong-valley', 'https://www.airbnb.co.kr/s/%EB%AC%B4%EC%A3%BC--%EC%A0%84%EB%9D%BC%EB%B6%81%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28', 650000, 1500000, '무주/구천동 8인 숙소 2박. 계곡 접근과 바비큐 규정 확인.', 0, 0, 'KTX 직접 없음', '대전/영동 환승보다 차량 직행 또는 렌터카가 현실적.', 700000, 1350000, '쏘카/렌터카 2대', '장거리 차량 2대, 보험, 유류, 통행료 포함 예상.', 180000, 520000, '곤돌라/계곡/주차', '덕유산 곤돌라, 주차, 계곡 이동 버퍼.'),
    ('yeongwol-donggang-rafting', 'https://www.airbnb.co.kr/s/%EC%98%81%EC%9B%94--%EA%B0%95%EC%9B%90%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28', 650000, 1450000, '영월/동강 8인 숙소 2박. 래프팅 집결지와 숙소 거리 확인.', 360000, 680000, '열차 제천/영월권', '제천/영월권 열차 왕복과 현지 이동 예상.', 450000, 950000, '렌터카 1-2대', '제천역 픽업 또는 차량 직행 시 보험/유류/주차 포함 예상.', 400000, 850000, '동강 래프팅/야간코스', '8명 래프팅, 천문대, 현지 이동 버퍼.')
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
      jsonb_build_object('category', '숙소', 'label', 'Airbnb/단체 숙소 2박', 'minAmount', cost_estimates.lodging_min, 'maxAmount', cost_estimates.lodging_max, 'note', cost_estimates.lodging_note, 'sourceUrl', cost_estimates.airbnb_url),
      jsonb_build_object('category', '교통', 'label', cost_estimates.transport_label, 'minAmount', cost_estimates.transport_min, 'maxAmount', cost_estimates.transport_max, 'note', cost_estimates.transport_note, 'sourceUrl', 'https://www.letskorail.com/'),
      jsonb_build_object('category', '렌트/차량', 'label', cost_estimates.rental_label, 'minAmount', cost_estimates.rental_min, 'maxAmount', cost_estimates.rental_max, 'note', cost_estimates.rental_note, 'sourceUrl', 'https://socar.kr/fare'),
      jsonb_build_object('category', '현지 비용', 'label', cost_estimates.local_label, 'minAmount', cost_estimates.local_min, 'maxAmount', cost_estimates.local_max, 'note', cost_estimates.local_note, 'sourceUrl', 'https://socar.kr/fare')
    ),
    'assumptions', jsonb_build_array(
      '8명, 2026-06-26 금요일 체크인, 2026-06-28 일요일 체크아웃, 2박 기준',
      'Airbnb와 쏘카는 실시간 재고/쿠폰/보험/청소비에 따라 최종 금액이 달라져 범위로 계산',
      '식비와 술값은 개인차가 커서 제외하고 숙소, 장거리 이동, 렌트/현지 이동, 대표 액티비티 버퍼만 포함',
      '날씨가 나쁘면 래프팅, 패러글라이딩, 수상레저는 취소 또는 대체 코스 필요'
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
