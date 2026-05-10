import type { TravelDestination, TravelTransportOption } from "../types/travel";

const costSourceUrls = [
  "https://www.letskorail.com/",
  "https://etk.srail.kr/",
  "https://socar.kr/fare",
  "https://www.airbnb.com/help/article/479",
];

const baseCostDates = {
  startDate: "2026-06-26",
  endDate: "2026-06-28",
  nights: 2,
  days: 3,
  people: 8,
  checkedAt: "2026-05-10",
};

const costAssumptions = [
  "8명, 2026-06-26 금요일 체크인, 2026-06-28 일요일 체크아웃, 2박 기준",
  "Airbnb와 쏘카는 실시간 재고/쿠폰/보험/청소비에 따라 최종 금액이 달라져 범위로 계산",
  "식비와 술값은 개인차가 커서 제외하고 숙소, 장거리 이동, 렌트/현지 이동, 대표 액티비티 버퍼만 포함",
];

export const activityFallbackDestinations: TravelDestination[] = [
  {
    id: "gapyeong-cheongpyeong-water",
    slug: "gapyeong-cheongpyeong-water",
    name: "가평 청평호/빠지",
    region: "경기도 가평군",
    destination_type: "alternative",
    latitude: 37.7169,
    longitude: 127.4899,
    marker_label: "가평",
    summary:
      "서울에서 가까운 여름 수상레저 후보. 빠지, 웨이크보드, 바나나보트, 계곡과 단체 펜션을 묶기 좋다.",
    recommended_months: "6월 말, 7월, 8월, 9월 초",
    recommended_duration: "2박3일 최적",
    main_image_url:
      "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chungpyeong_lake_on_August_4th,_2018.jpg",
    image_source_url:
      "https://commons.wikimedia.org/wiki/File:Chungpyeong_lake_on_August_4th,_2018.jpg",
    image_credit: "Choi2451 / Wikimedia Commons",
    tags: ["근교", "수상레저", "빠지", "계곡", "차량권장"],
    content: {
      fit: "멀리 가기 부담스러운데 물놀이와 숙소 바비큐를 확실히 하고 싶은 팀에 맞음",
      sourceUrls: [
        "https://www.gptour.go.kr/tour/tour_view.jsp?menu=tour&paramidx=TL0000094&submenu=main",
        "https://commons.wikimedia.org/wiki/File:Chungpyeong_lake_on_August_4th,_2018.jpg",
      ],
      blogEvidenceUrls: [
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EA%B0%80%ED%8F%89%20%EB%B9%A0%EC%A7%80%20%EC%97%AC%ED%96%89",
      ],
      reviewThemes: [
        "청평호 수상레저 업체가 많아 단체 물놀이 일정 짜기 쉬움",
        "서울권에서 가까워 금요일 퇴근 후 출발 부담이 낮음",
        "성수기 도로 정체와 숙소 소음/바비큐 규정 확인 필요",
      ],
      attractions: [
        {
          name: "청평호 수상레저",
          kind: "water sports",
          description: "수상스키, 웨이크보드, 바나나보트 등 단체 물놀이 후보",
          sourceUrl:
            "https://www.gptour.go.kr/tour/tour_view.jsp?menu=tour&paramidx=TL0000094&submenu=main",
          mapUrl:
            "https://map.naver.com/p/search/%EA%B0%80%ED%8F%89%20%EC%B2%AD%ED%8F%89%ED%98%B8%20%EC%88%98%EC%83%81%EB%A0%88%EC%A0%80",
          imageUrl:
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chungpyeong_lake_on_August_4th,_2018.jpg",
          imageSourceUrl:
            "https://commons.wikimedia.org/wiki/File:Chungpyeong_lake_on_August_4th,_2018.jpg",
        },
        {
          name: "어비계곡",
          kind: "valley",
          description: "물놀이 뒤 짧게 넣을 수 있는 계곡 후보",
          sourceUrl: "https://www.gptour.go.kr/",
          mapUrl:
            "https://map.kakao.com/?q=%EA%B0%80%ED%8F%89%20%EC%96%B4%EB%B9%84%EA%B3%84%EA%B3%A1",
        },
      ],
      stays: [
        {
          name: "가평 8인 Airbnb 공개 검색",
          area: "청평/설악/가평읍",
          notes: "빠지 픽업, 바비큐, 방 개수, 주차 확인 필요.",
          airbnbUrl:
            "https://www.airbnb.co.kr/s/%EA%B0%80%ED%8F%89--%EA%B2%BD%EA%B8%B0%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28",
        },
      ],
      activities: [
        {
          name: "빠지 무제한 패키지",
          risk: "우천/강풍 시 운영 확인",
          imageUrl:
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Chungpyeong_lake_on_August_4th,_2018.jpg",
          imageSourceUrl:
            "https://commons.wikimedia.org/wiki/File:Chungpyeong_lake_on_August_4th,_2018.jpg",
        },
        { name: "웨이크보드 강습", risk: "초보자 체력 소모 큼" },
      ],
      costEstimate: {
        baseDates: baseCostDates,
        lines: [
          {
            category: "숙소",
            label: "Airbnb/단체 숙소 2박",
            minAmount: 650000,
            maxAmount: 1500000,
            note: "가평/청평 8인 펜션 2박. 바비큐, 수영장, 픽업 여부에 따라 변동.",
            sourceUrl:
              "https://www.airbnb.co.kr/s/%EA%B0%80%ED%8F%89--%EA%B2%BD%EA%B8%B0%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28",
          },
          {
            category: "교통",
            label: "ITX/전철 또는 차량 이동",
            minAmount: 160000,
            maxAmount: 360000,
            note: "ITX/전철+택시 또는 차량 분승 예상 범위.",
            sourceUrl: "https://www.letskorail.com/",
          },
          {
            category: "렌트/차량",
            label: "쏘카/렌터카 2대 옵션",
            minAmount: 450000,
            maxAmount: 950000,
            note: "차량 직행 시 2박3일 차량 2대, 보험, 유류, 주차 포함 예상.",
            sourceUrl: "https://socar.kr/fare",
          },
          {
            category: "현지 비용",
            label: "빠지/수상레저",
            minAmount: 320000,
            maxAmount: 650000,
            note: "8명 수상레저 패키지와 현지 이동 버퍼.",
            sourceUrl: "https://socar.kr/fare",
          },
        ],
        assumptions: costAssumptions,
        sourceUrls: costSourceUrls,
      },
    },
  },
  {
    id: "inje-naerincheon-rafting",
    slug: "inje-naerincheon-rafting",
    name: "인제 내린천 래프팅",
    region: "강원특별자치도 인제군",
    destination_type: "alternative",
    latitude: 38.0704,
    longitude: 128.1709,
    marker_label: "인제",
    summary: "급류 래프팅, 짚트랙, ATV를 묶는 강원도 액티비티 후보.",
    recommended_months: "6월 말, 7월, 8월",
    recommended_duration: "2박3일 또는 3박4일",
    main_image_url:
      "https://commons.wikimedia.org/wiki/Special:Redirect/file/Gombaeryeong.jpg",
    image_source_url: "https://commons.wikimedia.org/wiki/File:Gombaeryeong.jpg",
    image_credit: "Wikimedia Commons",
    tags: ["래프팅", "계곡", "강원", "액티비티", "차량권장"],
    content: {
      fit: "물놀이를 조용히 보는 여행보다 직접 젖고 노는 액티비티형 팀에 적합",
      sourceUrls: [
        "https://russian.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=90563",
        "https://commons.wikimedia.org/wiki/File:Gombaeryeong.jpg",
      ],
      blogEvidenceUrls: [
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EC%9D%B8%EC%A0%9C%20%EB%82%B4%EB%A6%B0%EC%B2%9C%20%EB%9E%98%ED%94%84%ED%8C%85",
      ],
      reviewThemes: [
        "내린천은 여름 래프팅 명소로 알려져 있어 액티비티 목적이 선명함",
        "비가 온 뒤 수량과 운영 여부가 변수가 될 수 있음",
      ],
      attractions: [
        {
          name: "내린천 래프팅",
          kind: "rafting",
          description: "급류 기반의 대표 여름 액티비티",
          sourceUrl:
            "https://russian.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=90563",
          mapUrl:
            "https://map.naver.com/p/search/%EC%9D%B8%EC%A0%9C%20%EB%82%B4%EB%A6%B0%EC%B2%9C%20%EB%9E%98%ED%94%84%ED%8C%85",
          imageUrl:
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Gombaeryeong.jpg",
          imageSourceUrl:
            "https://commons.wikimedia.org/wiki/File:Gombaeryeong.jpg",
        },
      ],
      stays: [
        {
          name: "인제 8인 Airbnb 공개 검색",
          area: "인제읍/기린면",
          notes: "래프팅 업체 픽업 가능 여부와 샤워/건조 동선 확인.",
          airbnbUrl:
            "https://www.airbnb.co.kr/s/%EC%9D%B8%EC%A0%9C--%EA%B0%95%EC%9B%90%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28",
        },
      ],
      activities: [
        {
          name: "내린천 래프팅",
          risk: "수량, 우천, 안전교육 필수",
          imageUrl:
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Gombaeryeong.jpg",
          imageSourceUrl:
            "https://commons.wikimedia.org/wiki/File:Gombaeryeong.jpg",
        },
        { name: "짚트랙/ATV", risk: "현장 운영과 보험 확인" },
      ],
      costEstimate: {
        baseDates: baseCostDates,
        lines: [
          {
            category: "숙소",
            label: "Airbnb/단체 숙소 2박",
            minAmount: 650000,
            maxAmount: 1450000,
            note: "인제/내린천 8인 펜션 2박. 래프팅 업체 픽업과 샤워 동선 확인.",
          },
          {
            category: "렌트/차량",
            label: "쏘카/렌터카 2대",
            minAmount: 650000,
            maxAmount: 1250000,
            note: "2박3일 차량 2대, 보험, 유류, 통행료 포함 예상.",
          },
          {
            category: "현지 비용",
            label: "래프팅/짚트랙",
            minAmount: 360000,
            maxAmount: 800000,
            note: "8명 래프팅, 장비, 추가 액티비티 버퍼.",
          },
        ],
        assumptions: costAssumptions,
        sourceUrls: costSourceUrls,
      },
    },
  },
  {
    id: "danyang-adventure",
    slug: "danyang-adventure",
    name: "단양 패러글라이딩/남한강",
    region: "충청북도 단양군",
    destination_type: "alternative",
    latitude: 36.9846,
    longitude: 128.3655,
    marker_label: "단양",
    summary: "패러글라이딩, 만천하스카이워크, 남한강 잔도와 동굴을 묶는 산/강 액티비티 후보.",
    recommended_months: "6월 말, 7월, 8월, 9월 초",
    recommended_duration: "2박3일 또는 3박4일",
    main_image_url:
      "https://commons.wikimedia.org/wiki/Special:Redirect/file/Danyang_Travel_Day1_01_(31514871834).jpg",
    image_source_url:
      "https://commons.wikimedia.org/wiki/File:Danyang_Travel_Day1_01_(31514871834).jpg",
    image_credit: "Korea.net / Wikimedia Commons",
    tags: ["패러글라이딩", "강", "스카이워크", "동굴", "KTX가능"],
    content: {
      fit: "물놀이보다 하늘/전망/걷기 액티비티를 섞고 싶은 팀에 적합",
      sourceUrls: [
        "https://korean.visitkorea.or.kr/detail/rem_detail.do?cotid=f97b1d50-6ec7-469b-8891-501e3733bb8e",
        "https://commons.wikimedia.org/wiki/File:Danyang_Travel_Day1_01_(31514871834).jpg",
      ],
      blogEvidenceUrls: [
        "https://section.blog.naver.com/Search/Post.naver?keyword=%EB%8B%A8%EC%96%91%20%ED%8C%A8%EB%9F%AC%EA%B8%80%EB%9D%BC%EC%9D%B4%EB%94%A9%20%EC%97%AC%ED%96%89",
      ],
      reviewThemes: [
        "패러글라이딩과 만천하스카이워크가 대표 체험 포인트",
        "비/강풍이면 하늘 액티비티가 취소될 수 있어 대체 코스가 필요함",
      ],
      attractions: [
        {
          name: "단양 패러글라이딩",
          kind: "air sports",
          description: "남한강과 산지를 내려다보는 대표 액티비티",
          sourceUrl:
            "https://korean.visitkorea.or.kr/dgtourcard/biz/mbrb/mbrbPtcl.do?mbrbId=e8db9a60-84ae-4363-ba4b-1bedbfcaff04",
          mapUrl:
            "https://map.naver.com/p/search/%EB%8B%A8%EC%96%91%20%ED%8C%A8%EB%9F%AC%EA%B8%80%EB%9D%BC%EC%9D%B4%EB%94%A9",
          imageUrl:
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Danyang_Travel_Day1_01_(31514871834).jpg",
          imageSourceUrl:
            "https://commons.wikimedia.org/wiki/File:Danyang_Travel_Day1_01_(31514871834).jpg",
        },
      ],
      stays: [
        {
          name: "단양 8인 Airbnb 공개 검색",
          area: "단양읍/남한강변",
          notes: "패러글라이딩 픽업, 방 개수, 주차 확인.",
          airbnbUrl:
            "https://www.airbnb.co.kr/s/%EB%8B%A8%EC%96%91--%EC%B6%A9%EC%B2%AD%EB%B6%81%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28",
        },
      ],
      activities: [
        {
          name: "패러글라이딩",
          risk: "강풍/우천 취소 가능",
          imageUrl:
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Danyang_Travel_Day1_01_(31514871834).jpg",
          imageSourceUrl:
            "https://commons.wikimedia.org/wiki/File:Danyang_Travel_Day1_01_(31514871834).jpg",
        },
      ],
      costEstimate: {
        baseDates: baseCostDates,
        lines: [
          {
            category: "숙소",
            label: "Airbnb/단체 숙소 2박",
            minAmount: 650000,
            maxAmount: 1400000,
            note: "단양 8인 숙소 2박. 단양읍/강변권은 주차와 객실 구조 확인.",
          },
          {
            category: "교통",
            label: "열차 + 택시",
            minAmount: 320000,
            maxAmount: 620000,
            note: "제천/단양권 열차 왕복과 택시/픽업 예상.",
          },
          {
            category: "현지 비용",
            label: "패러글라이딩/스카이워크",
            minAmount: 600000,
            maxAmount: 1200000,
            note: "패러글라이딩 8명 기준 비용 편차가 커서 넓게 산정.",
          },
        ],
        assumptions: costAssumptions,
        sourceUrls: costSourceUrls,
      },
    },
  },
  {
    id: "muju-gucheondong-valley",
    slug: "muju-gucheondong-valley",
    name: "무주 구천동/덕유산",
    region: "전북특별자치도 무주군",
    destination_type: "alternative",
    latitude: 35.9042,
    longitude: 127.7522,
    marker_label: "무주",
    summary: "계곡 물놀이, 덕유산 숲, 리조트 액티비티를 묶는 내륙 여름 후보.",
    recommended_months: "6월 말, 7월, 8월, 9월 초",
    recommended_duration: "3박4일 추천, 2박3일 가능",
    main_image_url:
      "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mujugun_County_33_(16834249346).jpg",
    image_source_url:
      "https://commons.wikimedia.org/wiki/File:Mujugun_County_33_(16834249346).jpg",
    image_credit: "Korea.net / Wikimedia Commons",
    tags: ["계곡", "덕유산", "리조트", "내륙휴식", "차량권장"],
    content: {
      fit: "바다 대신 계곡과 산에서 쉬면서 리조트형 액티비티를 넣고 싶은 팀에 적합",
      sourceUrls: [
        "https://encykorea.aks.ac.kr/Article/E0019248",
        "https://commons.wikimedia.org/wiki/File:Mujugun_County_33_(16834249346).jpg",
      ],
      reviewThemes: [
        "구천동 계곡과 덕유산 숲은 한여름 더위 피하기 좋음",
        "차량이 있어야 숙소, 계곡, 리조트 동선이 편함",
      ],
      attractions: [
        {
          name: "무주구천동 계곡",
          kind: "valley",
          description: "덕유산권 대표 계곡 산책/물놀이 후보",
          sourceUrl: "https://encykorea.aks.ac.kr/Article/E0019248",
          mapUrl:
            "https://map.naver.com/p/search/%EB%AC%B4%EC%A3%BC%EA%B5%AC%EC%B2%9C%EB%8F%99%20%EA%B3%84%EA%B3%A1",
          imageUrl:
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mujugun_County_33_(16834249346).jpg",
          imageSourceUrl:
            "https://commons.wikimedia.org/wiki/File:Mujugun_County_33_(16834249346).jpg",
        },
      ],
      stays: [
        {
          name: "무주 8인 Airbnb 공개 검색",
          area: "설천/구천동/무주읍",
          notes: "계곡 접근, 바비큐, 방 개수, 주차 확인.",
          airbnbUrl:
            "https://www.airbnb.co.kr/s/%EB%AC%B4%EC%A3%BC--%EC%A0%84%EB%9D%BC%EB%B6%81%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28",
        },
      ],
      activities: [
        {
          name: "구천동 계곡 물놀이",
          risk: "우천 뒤 수량과 안전 확인",
          imageUrl:
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Mujugun_County_33_(16834249346).jpg",
          imageSourceUrl:
            "https://commons.wikimedia.org/wiki/File:Mujugun_County_33_(16834249346).jpg",
        },
      ],
      costEstimate: {
        baseDates: baseCostDates,
        lines: [
          {
            category: "숙소",
            label: "Airbnb/단체 숙소 2박",
            minAmount: 650000,
            maxAmount: 1500000,
            note: "무주/구천동 8인 숙소 2박. 계곡 접근과 바비큐 규정 확인.",
          },
          {
            category: "렌트/차량",
            label: "쏘카/렌터카 2대",
            minAmount: 700000,
            maxAmount: 1350000,
            note: "장거리 차량 2대, 보험, 유류, 통행료 포함 예상.",
          },
          {
            category: "현지 비용",
            label: "곤돌라/계곡/주차",
            minAmount: 180000,
            maxAmount: 520000,
            note: "덕유산 곤돌라, 주차, 계곡 이동 버퍼.",
          },
        ],
        assumptions: costAssumptions,
        sourceUrls: costSourceUrls,
      },
    },
  },
  {
    id: "yeongwol-donggang-rafting",
    slug: "yeongwol-donggang-rafting",
    name: "영월 동강 래프팅",
    region: "강원특별자치도 영월군",
    destination_type: "alternative",
    latitude: 37.1834,
    longitude: 128.4612,
    marker_label: "영월",
    summary: "동강 래프팅, 한반도지형, 별마로천문대를 묶는 강원 내륙 액티비티 후보.",
    recommended_months: "6월 말, 7월, 8월, 9월 초",
    recommended_duration: "2박3일 또는 3박4일",
    main_image_url:
      "https://commons.wikimedia.org/wiki/Special:Redirect/file/Dong-gang(river)_flows_near_by_Yeongwol_03.jpg",
    image_source_url:
      "https://commons.wikimedia.org/wiki/File:Dong-gang(river)_flows_near_by_Yeongwol_03.jpg",
    image_credit: "Jjw / Wikimedia Commons",
    tags: ["래프팅", "강", "별보기", "강원", "렌터카추천"],
    content: {
      fit: "래프팅과 밤 별보기까지 넣어 액티비티 색이 분명한 내륙 여행을 만들기 좋음",
      sourceUrls: [
        "https://www.yw.go.kr/tour/selectTourCntntsWebView.do?ctgry=2&key=560&pageUnit=9&searchCnd=all&tourNo=635",
        "https://commons.wikimedia.org/wiki/File:Dong-gang(river)_flows_near_by_Yeongwol_03.jpg",
      ],
      reviewThemes: [
        "동강 래프팅은 급류와 풍경을 같이 잡는 여름 액티비티",
        "별마로천문대와 한반도지형으로 비물놀이 대체 코스를 만들기 쉬움",
      ],
      attractions: [
        {
          name: "동강 래프팅",
          kind: "rafting",
          description: "영월 대표 여름 강 액티비티",
          sourceUrl:
            "https://www.yw.go.kr/tour/selectTourCntntsWebView.do?ctgry=2&key=560&pageUnit=9&searchCnd=all&tourNo=635",
          mapUrl:
            "https://map.naver.com/p/search/%EC%98%81%EC%9B%94%20%EB%8F%99%EA%B0%95%20%EB%9E%98%ED%94%84%ED%8C%85",
          imageUrl:
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Dong-gang(river)_flows_near_by_Yeongwol_03.jpg",
          imageSourceUrl:
            "https://commons.wikimedia.org/wiki/File:Dong-gang(river)_flows_near_by_Yeongwol_03.jpg",
        },
      ],
      stays: [
        {
          name: "영월 8인 Airbnb 공개 검색",
          area: "영월읍/동강권",
          notes: "래프팅 업체 접근, 샤워/건조 동선, 주차 확인.",
          airbnbUrl:
            "https://www.airbnb.co.kr/s/%EC%98%81%EC%9B%94--%EA%B0%95%EC%9B%90%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8&checkin=2026-06-26&checkout=2026-06-28",
        },
      ],
      activities: [
        {
          name: "동강 래프팅",
          risk: "수량, 안전교육, 음주 금지",
          imageUrl:
            "https://commons.wikimedia.org/wiki/Special:Redirect/file/Dong-gang(river)_flows_near_by_Yeongwol_03.jpg",
          imageSourceUrl:
            "https://commons.wikimedia.org/wiki/File:Dong-gang(river)_flows_near_by_Yeongwol_03.jpg",
        },
      ],
      costEstimate: {
        baseDates: baseCostDates,
        lines: [
          {
            category: "숙소",
            label: "Airbnb/단체 숙소 2박",
            minAmount: 650000,
            maxAmount: 1450000,
            note: "영월/동강 8인 숙소 2박. 래프팅 집결지와 숙소 거리 확인.",
          },
          {
            category: "교통",
            label: "열차 제천/영월권",
            minAmount: 360000,
            maxAmount: 680000,
            note: "제천/영월권 열차 왕복과 현지 이동 예상.",
          },
          {
            category: "렌트/차량",
            label: "렌터카 1-2대",
            minAmount: 450000,
            maxAmount: 950000,
            note: "제천역 픽업 또는 차량 직행 시 보험/유류/주차 포함 예상.",
          },
          {
            category: "현지 비용",
            label: "동강 래프팅/야간코스",
            minAmount: 400000,
            maxAmount: 850000,
            note: "8명 래프팅, 천문대, 현지 이동 버퍼.",
          },
        ],
        assumptions: costAssumptions,
        sourceUrls: costSourceUrls,
      },
    },
  },
];

export const activityFallbackTransportOptions: TravelTransportOption[] = [
  {
    id: "gapyeong-car-only",
    destination_id: "gapyeong-cheongpyeong-water",
    mode: "car_only",
    label: "차량 직행",
    route_steps: ["잠실 출발", "서울양양고속도로/46번 국도", "청평호 또는 가평 숙소"],
    estimated_time: "약 1.5-2.5시간",
    estimated_cost: "유류/주차+렌트 시 중간",
    requires_car: true,
    station_rental_recommended: false,
    risk_note: "금요일 저녁과 일요일 복귀 정체 확인",
    sort_order: 10,
  },
  {
    id: "inje-car-only",
    destination_id: "inje-naerincheon-rafting",
    mode: "car_only",
    label: "차량 직행",
    route_steps: ["잠실 출발", "서울양양고속도로", "인제/내린천 숙소"],
    estimated_time: "약 2.5-4시간",
    estimated_cost: "유류/통행료+렌트 시 중상",
    requires_car: true,
    station_rental_recommended: false,
    risk_note: "래프팅 후 운전 피로와 음주 일정 분리 필요",
    sort_order: 10,
  },
  {
    id: "danyang-train-local",
    destination_id: "danyang-adventure",
    mode: "ktx_local",
    label: "KTX/무궁화 + 택시",
    route_steps: ["잠실에서 청량리/서울역 이동", "제천/단양역", "택시 또는 픽업"],
    estimated_time: "약 2.5-4시간",
    estimated_cost: "열차+택시 1인 중간",
    requires_car: false,
    station_rental_recommended: false,
    risk_note: "패러글라이딩 픽업 가능 여부 확인",
    sort_order: 10,
  },
  {
    id: "muju-car-only",
    destination_id: "muju-gucheondong-valley",
    mode: "car_only",
    label: "차량 직행",
    route_steps: ["잠실 출발", "경부/통영대전고속도로", "무주 구천동 숙소"],
    estimated_time: "약 3-5시간",
    estimated_cost: "유류/통행료+렌트 시 중상",
    requires_car: true,
    station_rental_recommended: false,
    risk_note: "장거리 운전 분담과 계곡 주차 확인",
    sort_order: 10,
  },
  {
    id: "yeongwol-train-rental",
    destination_id: "yeongwol-donggang-rafting",
    mode: "ktx_rental",
    label: "KTX 제천 + 렌터카",
    route_steps: ["잠실에서 청량리/서울역 이동", "제천역", "렌터카로 영월/동강 이동"],
    estimated_time: "약 3-4.5시간",
    estimated_cost: "열차+렌터카로 중상",
    requires_car: true,
    station_rental_recommended: true,
    risk_note: "래프팅 집결지와 숙소 간 거리 확인",
    sort_order: 10,
  },
];
