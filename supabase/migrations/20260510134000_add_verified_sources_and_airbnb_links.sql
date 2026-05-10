update public.travel_destinations
set content = content || '{
  "blogEvidenceUrls": [
    "https://blog.naver.com/PostView.naver?blogId=houec&logNo=222460685313",
    "https://blog.naver.com/PostView.naver?blogId=nailstan&logNo=150186233293"
  ],
  "stays": [
    {
      "name": "광안리 8인 Airbnb 공개 검색",
      "area": "광안리/민락",
      "notes": "야경, 식당, 카페 동선이 좋은 권역. 실제 예약 가능 여부와 침실/욕실 수는 Airbnb에서 날짜 입력 후 확인.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%EA%B4%91%EC%95%88%EB%A6%AC--%EB%B6%80%EC%82%B0--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://www.visitbusan.net/en/index.do"]
    },
    {
      "name": "해운대 8인 Airbnb 공개 검색",
      "area": "해운대/미포",
      "notes": "해수욕장과 동백섬 접근성이 좋은 권역. 성수기 가격과 주차 가능 여부 확인 필요.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%ED%95%B4%EC%9A%B4%EB%8C%80--%EB%B6%80%EC%82%B0--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://www.busan.go.kr/eng/beaches/1325815"]
    },
    {
      "name": "송정/기장 8인 Airbnb 공개 검색",
      "area": "송정/기장",
      "notes": "차량 이동을 전제로 한 단체 숙소 후보 권역. 해운대/광안리 야간 이동 시간 확인 필요.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%EC%86%A1%EC%A0%95--%EB%B6%80%EC%82%B0--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://www.visitbusan.net/en/index.do"]
    }
  ]
}'::jsonb
where id = 'busan-haeundae-gwangalli';

update public.travel_destinations
set content = content || '{
  "blogEvidenceUrls": [
    "https://blog.naver.com/PostView.naver?blogId=richer1214&logNo=223570659806",
    "https://blog.naver.com/PostView.naver?blogId=ar2270&logNo=220272498427"
  ],
  "stays": [
    {
      "name": "강릉 8인 Airbnb 공개 검색",
      "area": "경포/강문/안목",
      "notes": "KTX 이후 택시 이동이 비교적 쉬운 권역. 침실 수와 주차, 해변 도보 여부 확인 필요.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%EA%B0%95%EB%A6%89--%EA%B0%95%EC%9B%90%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://www.gn.go.kr/eng/sub04_01_01.do"]
    },
    {
      "name": "양양 8인 Airbnb 공개 검색",
      "area": "하조대/인구/죽도",
      "notes": "서핑 목적이면 적합한 권역. 차량 이동과 밤 소음, 성수기 가격 확인 필요.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%EC%96%91%EC%96%91--%EA%B0%95%EC%9B%90%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://tour.yangyang.go.kr/"]
    },
    {
      "name": "주문진/사천 8인 Airbnb 공개 검색",
      "area": "강릉 북부",
      "notes": "독채/펜션형 후보가 많은 권역. 차량 또는 택시 분승 전제.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%EC%A3%BC%EB%AC%B8%EC%A7%84--%EA%B0%95%EB%A6%89--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://www.gn.go.kr/tour/index.do"]
    }
  ]
}'::jsonb
where id = 'gangneung-yangyang';

update public.travel_destinations
set content = content || '{
  "blogEvidenceUrls": [],
  "stays": [
    {
      "name": "여수 8인 Airbnb 공개 검색",
      "area": "여수엑스포역/오동도",
      "notes": "KTX 도착 후 짐 이동이 쉬운 권역. 8인은 객실 구조와 엘리베이터 확인 필요.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%EC%97%AC%EC%88%98--%EC%A0%84%EB%9D%BC%EB%82%A8%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://www.yeosu.go.kr/en/travel"]
    },
    {
      "name": "돌산 8인 Airbnb 공개 검색",
      "area": "돌산",
      "notes": "오션뷰/풀빌라 후보 권역. 차량 이동과 주차, 바비큐 규정 확인 필요.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%EB%8F%8C%EC%82%B0--%EC%97%AC%EC%88%98--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://www.yeosu.go.kr/en/travel/10tour/cablecar"]
    },
    {
      "name": "종포/낭만포차 8인 Airbnb 공개 검색",
      "area": "종포/이순신광장",
      "notes": "저녁 동선이 좋은 권역. 소음과 주차 여부 확인 필요.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%EC%A2%85%ED%8F%AC--%EC%97%AC%EC%88%98--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://www.yeosu.go.kr/en/leisure/city_tour/course_05"]
    }
  ]
}'::jsonb
where id = 'yeosu-night-sea';

update public.travel_destinations
set content = content || '{
  "blogEvidenceUrls": [
    "https://blog.naver.com/PostView.naver?blogId=hwjin1121&logNo=222995527284",
    "https://blog.naver.com/PostView.nhn?blogId=yurding&logNo=223370227443"
  ],
  "stays": [
    {
      "name": "안면도 8인 Airbnb 공개 검색",
      "area": "꽃지/방포",
      "notes": "서해 일몰과 바비큐 숙소 중심 권역. 8인 가능, 주차, 바비큐 가능 여부 확인 필요.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%EC%95%88%EB%A9%B4%EB%8F%84--%ED%83%9C%EC%95%88--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://www.taean.go.kr/tour.do"]
    },
    {
      "name": "태안 8인 Airbnb 공개 검색",
      "area": "태안/만리포",
      "notes": "차량 이동 단체 여행에 적합한 검색 후보. 해변 접근성과 편의점 거리 확인 필요.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%ED%83%9C%EC%95%88--%EC%B6%A9%EC%B2%AD%EB%82%A8%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://www.taean.go.kr/tour.do"]
    },
    {
      "name": "만리포 8인 Airbnb 공개 검색",
      "area": "만리포",
      "notes": "해수욕장 중심 권역. 안면도 남부 명소와 거리는 별도 확인 필요.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%EB%A7%8C%EB%A6%AC%ED%8F%AC--%ED%83%9C%EC%95%88--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://www.taean.go.kr/prog/tursmCn/tour/sub02_02_04/view.do?cntno=6"]
    }
  ]
}'::jsonb
where id = 'taean-anmyeondo';

update public.travel_destinations
set content = content || '{
  "blogEvidenceUrls": [],
  "stays": [
    {
      "name": "통영 8인 Airbnb 공개 검색",
      "area": "통영항/도남",
      "notes": "케이블카, 루지, 중앙시장 접근 후보. 8인 단체는 주차와 욕실 수 확인 필요.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%ED%86%B5%EC%98%81--%EA%B2%BD%EC%83%81%EB%82%A8%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://www.utour.go.kr/"]
    },
    {
      "name": "거제 8인 Airbnb 공개 검색",
      "area": "일운/지세포/와현",
      "notes": "외도와 바람의언덕 접근 후보. 렌터카 이동 전제.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%EA%B1%B0%EC%A0%9C--%EA%B2%BD%EC%83%81%EB%82%A8%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://tour.geoje.go.kr/index.geoje"]
    },
    {
      "name": "지세포 8인 Airbnb 공개 검색",
      "area": "거제 지세포",
      "notes": "유람선/해안 이동에 적합한 권역. 장보기와 밤 이동 확인 필요.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%EC%A7%80%EC%84%B8%ED%8F%AC--%EA%B1%B0%EC%A0%9C--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://tour.geoje.go.kr/index.geoje"]
    }
  ]
}'::jsonb
where id = 'tongyeong-geoje';

update public.travel_destinations
set content = content || '{
  "blogEvidenceUrls": [
    "https://blog.naver.com/PostView.nhn?blogId=777phil&logNo=222278255189",
    "https://blog.naver.com/PostView.nhn?blogId=rlfghkddnd&logNo=223394861280"
  ],
  "stays": [
    {
      "name": "남해 8인 Airbnb 공개 검색",
      "area": "남해군",
      "notes": "독채/풀빌라형 후보 검색. 차량 이동, 바비큐, 침실 수 확인 필요.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%EB%82%A8%ED%95%B4--%EA%B2%BD%EC%83%81%EB%82%A8%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://www.namhae.go.kr/tour/main.web"]
    },
    {
      "name": "독일마을 8인 Airbnb 공개 검색",
      "area": "삼동면/독일마을",
      "notes": "카페와 사진 코스 접근 후보. 주차와 소음 규정 확인 필요.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%EB%82%A8%ED%95%B4%EB%8F%85%EC%9D%BC%EB%A7%88%EC%9D%84--%EB%82%A8%ED%95%B4--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://www.namhae.go.kr/tour/00007/00056.web?amode=view&idx=177&tord=name"]
    },
    {
      "name": "상주은모래비치 8인 Airbnb 공개 검색",
      "area": "상주/미조",
      "notes": "해변과 보리암 동선 후보. 성수기 가격과 편의시설 확인 필요.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%EC%83%81%EC%A3%BC%EC%9D%80%EB%AA%A8%EB%9E%98%EB%B9%84%EC%B9%98--%EB%82%A8%ED%95%B4--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://www.namhae.go.kr/tour/main.web"]
    }
  ]
}'::jsonb
where id = 'namhae-coast';

update public.travel_destinations
set content = content || '{
  "blogEvidenceUrls": [],
  "stays": [
    {
      "name": "포항 8인 Airbnb 공개 검색",
      "area": "포항 시내/영일대",
      "notes": "KTX 후 택시 이동이 가능한 권역. 스페이스워크/영일대 접근 확인.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%ED%8F%AC%ED%95%AD--%EA%B2%BD%EC%83%81%EB%B6%81%EB%8F%84--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://pohang.go.kr/phtour/index.do"]
    },
    {
      "name": "구룡포 8인 Airbnb 공개 검색",
      "area": "구룡포",
      "notes": "일본인가옥거리와 해산물 동선 후보. 차량 이동 전제.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%EA%B5%AC%EB%A3%A1%ED%8F%AC--%ED%8F%AC%ED%95%AD--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=14955"]
    },
    {
      "name": "호미곶 8인 Airbnb 공개 검색",
      "area": "호미곶",
      "notes": "일출과 해안도로 중심 후보. 밤 이동과 식당 선택지 확인 필요.",
      "airbnbUrl": "https://www.airbnb.co.kr/s/%ED%98%B8%EB%AF%B8%EA%B3%B6--%ED%8F%AC%ED%95%AD--%ED%95%9C%EA%B5%AD/homes?adults=8",
      "sourceUrls": ["https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=94539"]
    }
  ]
}'::jsonb
where id = 'pohang-guryongpo';
