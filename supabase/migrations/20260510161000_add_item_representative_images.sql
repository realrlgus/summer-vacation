with attraction_media(destination_id, item_name, image_url, image_source_url) as (
  values
    ('gangneung-yangyang', '경포해변', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Gyeongpo_Beach_20220502_023.jpg', 'https://commons.wikimedia.org/wiki/File:Gyeongpo_Beach_20220502_023.jpg'),
    ('gangneung-yangyang', '안목 커피거리', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Anmok_beach.jpg', 'https://commons.wikimedia.org/wiki/File:Anmok_beach.jpg'),
    ('gangneung-yangyang', '주문진/향호해변', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Jumunjin_Beach_20220501_035.jpg', 'https://commons.wikimedia.org/wiki/File:Jumunjin_Beach_20220501_035.jpg'),
    ('gangneung-yangyang', '양양 서피비치', 'https://tong.visitkorea.or.kr/cms/resource/90/2745190_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=34381'),
    ('ganghwa-seokmodo', '강화씨사이드리조트 루지', 'https://tong.visitkorea.or.kr/cms/resource/44/3369644_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=139945'),
    ('ganghwa-seokmodo', '보문사', 'https://tong.visitkorea.or.kr/cms/resource/41/3041941_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=112017'),
    ('ganghwa-seokmodo', '동막해변/갯벌', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Ganghwa1.jpg', 'https://commons.wikimedia.org/wiki/File:Ganghwa1.jpg'),
    ('ganghwa-seokmodo', '석모도 미네랄 온천', 'https://english.visitkorea.or.kr/public/images/2025/06/10/ae44704fc05841109fa381d06d86d13a.png', 'https://english.visitkorea.or.kr/svc/whereToGo/hdrdslt/hdrdsltView.do?crsSn=267'),
    ('gunsan-seonyudo', '선유도', 'https://tong.visitkorea.or.kr/cms/resource/39/2558339_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=94264'),
    ('gunsan-seonyudo', '선유도해수욕장', 'https://tong.visitkorea.or.kr/cms/resource/39/3350739_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=15076'),
    ('gunsan-seonyudo', '무녀도/장자도 연결 코스', 'https://tong.visitkorea.or.kr/cms/resource/21/2824821_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=15047'),
    ('gunsan-seonyudo', '장자도 대장봉', 'https://tong.visitkorea.or.kr/cms/resource/30/3055430_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=15053'),
    ('namhae-coast', '가천 다랭이마을', 'https://tong.visitkorea.or.kr/cms/resource/96/2703896_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=90688'),
    ('namhae-coast', '남해 독일마을', 'https://tong.visitkorea.or.kr/cms/resource/04/2939704_image2_1.bmp', 'https://english.visitkorea.or.kr/svc/whereToGo/locIntrdn/rgnContentsView.do?vcontsId=75683'),
    ('namhae-coast', '상주은모래비치', 'https://tong.visitkorea.or.kr/cms/resource/92/2939692_image2_1.bmp', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=103281'),
    ('namhae-coast', '보리암', 'https://tong.visitkorea.or.kr/cms/resource/58/2939658_image2_1.bmp', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=76009'),
    ('mokpo-sinan-jeungdo', '목포 해상케이블카', 'https://tong.visitkorea.or.kr/cms/resource/20/3554020_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/whereToGo/locIntrdn/rgnContentsView.do?vcontsId=60936'),
    ('mokpo-sinan-jeungdo', '목포 갓바위', 'https://tong.visitkorea.or.kr/cms/resource/41/3063741_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=81622'),
    ('mokpo-sinan-jeungdo', '증도 짱뚱어다리', 'https://tong.visitkorea.or.kr/cms/resource/83/2612383_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=69600'),
    ('mokpo-sinan-jeungdo', '증도/태평염전', 'https://tong.visitkorea.or.kr/cms/resource/67/2026067_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=93924'),
    ('boryeong-daecheon', '대천해수욕장', 'https://tong.visitkorea.or.kr/cms/resource/09/2877209_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=105704'),
    ('boryeong-daecheon', '무창포해수욕장', 'https://tong.visitkorea.or.kr/cms/resource/99/1894399_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=74238'),
    ('boryeong-daecheon', '짚트랙 코리아', 'https://tong.visitkorea.or.kr/cms/resource/39/2945939_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=191337'),
    ('boryeong-daecheon', '대천 스카이바이크', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Korea-Boreyong-Daecheon_Beach-01.jpg', 'https://commons.wikimedia.org/wiki/File:Korea-Boreyong-Daecheon_Beach-01.jpg'),
    ('busan-haeundae-gwangalli', '해운대 해수욕장', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Haeundae_Beach_in_Busan.jpg', 'https://commons.wikimedia.org/wiki/File:Haeundae_Beach_in_Busan.jpg'),
    ('busan-haeundae-gwangalli', '광안리 해수욕장', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Gwangalli_Beach_in_Busan.jpg', 'https://commons.wikimedia.org/wiki/File:Gwangalli_Beach_in_Busan.jpg'),
    ('busan-haeundae-gwangalli', '민락수변공원/회센터', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Jagalchi_Market_20200523_018.jpg', 'https://commons.wikimedia.org/wiki/File:Jagalchi_Market_20200523_018.jpg'),
    ('busan-haeundae-gwangalli', '동백섬', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Dongbaekseom_island,_Busan.jpg', 'https://commons.wikimedia.org/wiki/File:Dongbaekseom_island,_Busan.jpg'),
    ('yeosu-night-sea', '여수 해상케이블카', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Yeosu_Maritime_Cable_Car_View.jpg', 'https://commons.wikimedia.org/wiki/File:Yeosu_Maritime_Cable_Car_View.jpg'),
    ('yeosu-night-sea', '오동도', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Yeosu_Odongdo_20180929_002.jpg', 'https://commons.wikimedia.org/wiki/File:Yeosu_Odongdo_20180929_002.jpg'),
    ('yeosu-night-sea', '낭만포차 거리', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Yeosu_harbour_2015-08-13(1).jpg', 'https://commons.wikimedia.org/wiki/File:Yeosu_harbour_2015-08-13(1).jpg'),
    ('yeosu-night-sea', '향일암', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Hyangiram_hermitage_03.jpg', 'https://commons.wikimedia.org/wiki/File:Hyangiram_hermitage_03.jpg'),
    ('taean-anmyeondo', '꽃지해수욕장', 'https://tong.visitkorea.or.kr/cms/resource/06/2649006_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/whereToGo/locIntrdn/rgnContentsView.do?vcontsId=105248'),
    ('taean-anmyeondo', '안면도 자연휴양림', 'https://tong.visitkorea.or.kr/cms/resource/70/2031770_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/whereToGo/locIntrdn/rgnContentsView.do?vcontsId=110628'),
    ('taean-anmyeondo', '만리포해수욕장', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/태안해안국립공원_만리포_1.jpg', 'https://commons.wikimedia.org/wiki/File:태안해안국립공원_만리포_1.jpg'),
    ('taean-anmyeondo', '천리포수목원', 'https://tong.visitkorea.or.kr/cms/resource/95/637295_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=200579'),
    ('tongyeong-geoje', '통영 케이블카/미륵산', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Korea-Tongyeong-Hallyeo_Waterway_Observation_Cable_Car-01.jpg', 'https://commons.wikimedia.org/wiki/File:Korea-Tongyeong-Hallyeo_Waterway_Observation_Cable_Car-01.jpg'),
    ('tongyeong-geoje', '스카이라인 루지 통영', 'https://tong.visitkorea.or.kr/cms/resource/30/2488130_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=55669'),
    ('tongyeong-geoje', '동피랑/강구안', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Korea-Tongyeong-Dongpirang_Village-01.jpg', 'https://commons.wikimedia.org/wiki/File:Korea-Tongyeong-Dongpirang_Village-01.jpg'),
    ('tongyeong-geoje', '거제 바람의언덕', 'https://tong.visitkorea.or.kr/cms/resource/04/2612904_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=77569'),
    ('pohang-guryongpo', '스페이스워크', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/SpaceWalk_(walkable_sculpture,_Pohang_2021)_Mutter_Genth_03.jpg', 'https://commons.wikimedia.org/wiki/File:SpaceWalk_(walkable_sculpture,_Pohang_2021)_Mutter_Genth_03.jpg'),
    ('pohang-guryongpo', '영일대해수욕장', 'https://tong.visitkorea.or.kr/cms/resource/00/2940100_image2_1.bmp', 'https://english.visitkorea.or.kr/svc/whereToGo/locIntrdn/rgnContentsView.do?vcontsId=91112'),
    ('pohang-guryongpo', '호미곶', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Pohang_Homigot2.jpg', 'https://commons.wikimedia.org/wiki/File:Pohang_Homigot2.jpg'),
    ('pohang-guryongpo', '구룡포 일본인가옥거리', 'https://tong.visitkorea.or.kr/cms/resource/18/2940118_image2_1.bmp', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=14955')
),
updated_attractions as (
  select
    destinations.id,
    jsonb_agg(
      case
        when attraction_media.item_name is null then attraction.element
        else attraction.element || jsonb_build_object(
          'imageUrl', attraction_media.image_url,
          'imageSourceUrl', attraction_media.image_source_url
        )
      end
      order by attraction.ordinality
    ) as next_attractions
  from public.travel_destinations destinations
  cross join lateral jsonb_array_elements(destinations.content->'attractions')
    with ordinality as attraction(element, ordinality)
  left join attraction_media
    on attraction_media.destination_id = destinations.id
    and attraction_media.item_name = attraction.element->>'name'
  group by destinations.id
)
update public.travel_destinations destinations
set content = jsonb_set(destinations.content, '{attractions}', updated_attractions.next_attractions)
from updated_attractions
where destinations.id = updated_attractions.id;

with activity_media(destination_id, item_name, image_url, image_source_url) as (
  values
    ('gangneung-yangyang', '양양 서핑 강습', 'https://tong.visitkorea.or.kr/cms/resource/90/2745190_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=34381'),
    ('gangneung-yangyang', '안목/강문 카페 투어', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Anmok_beach.jpg', 'https://commons.wikimedia.org/wiki/File:Anmok_beach.jpg'),
    ('gangneung-yangyang', '해변 바비큐 숙소 일정', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Gyeongpo_Beach_20220502_025.jpg', 'https://commons.wikimedia.org/wiki/File:Gyeongpo_Beach_20220502_025.jpg'),
    ('ganghwa-seokmodo', '루지와 곤돌라', 'https://tong.visitkorea.or.kr/cms/resource/44/3369644_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=139945'),
    ('ganghwa-seokmodo', '서해 일몰/갯벌 산책', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Ganghwa1.jpg', 'https://commons.wikimedia.org/wiki/File:Ganghwa1.jpg'),
    ('ganghwa-seokmodo', '숙소 바비큐와 온천', 'https://english.visitkorea.or.kr/public/images/2025/06/10/ae44704fc05841109fa381d06d86d13a.png', 'https://english.visitkorea.or.kr/svc/whereToGo/hdrdslt/hdrdsltView.do?crsSn=267'),
    ('gunsan-seonyudo', '섬 자전거/도보 이동', 'https://tong.visitkorea.or.kr/cms/resource/21/2824821_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=15047'),
    ('gunsan-seonyudo', '선유도 해변 일정', 'https://tong.visitkorea.or.kr/cms/resource/39/3350739_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=15076'),
    ('gunsan-seonyudo', '군산 먹거리 투어', 'https://tong.visitkorea.or.kr/cms/resource/39/2558339_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=94264'),
    ('namhae-coast', '남해 해안 드라이브', 'https://tong.visitkorea.or.kr/cms/resource/77/1293277_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/whereToGo/locIntrdn/rgnContentsView.do?vcontsId=73013'),
    ('namhae-coast', '독채 숙소 바비큐', 'https://tong.visitkorea.or.kr/cms/resource/04/2939704_image2_1.bmp', 'https://english.visitkorea.or.kr/svc/whereToGo/locIntrdn/rgnContentsView.do?vcontsId=75683'),
    ('namhae-coast', '다랭이마을 산책', 'https://tong.visitkorea.or.kr/cms/resource/96/2703896_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=90688'),
    ('mokpo-sinan-jeungdo', '목포 해상케이블카 야경', 'https://tong.visitkorea.or.kr/cms/resource/20/3554020_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/whereToGo/locIntrdn/rgnContentsView.do?vcontsId=60936'),
    ('mokpo-sinan-jeungdo', '목포 해산물/시장 투어', 'https://tong.visitkorea.or.kr/cms/resource/41/3063741_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=81622'),
    ('mokpo-sinan-jeungdo', '증도 갯벌/염전 코스', 'https://tong.visitkorea.or.kr/cms/resource/67/2026067_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=93924'),
    ('boryeong-daecheon', '대천 해변 물놀이', 'https://tong.visitkorea.or.kr/cms/resource/09/2877209_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=105704'),
    ('boryeong-daecheon', '짚트랙/스카이바이크', 'https://tong.visitkorea.or.kr/cms/resource/39/2945939_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=191337'),
    ('boryeong-daecheon', '무창포 바닷길', 'https://tong.visitkorea.or.kr/cms/resource/99/1894399_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=74238'),
    ('busan-haeundae-gwangalli', '광안리 요트/해상 액티비티', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Busan_Gwangalli_Night.jpg', 'https://commons.wikimedia.org/wiki/File:Busan_Gwangalli_Night.jpg'),
    ('busan-haeundae-gwangalli', '해변 피크닉과 야경 산책', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Gwangalli_Beach_in_Busan.jpg', 'https://commons.wikimedia.org/wiki/File:Gwangalli_Beach_in_Busan.jpg'),
    ('busan-haeundae-gwangalli', '해산물 시장/포차 투어', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Jagalchi_Market_20200523_018.jpg', 'https://commons.wikimedia.org/wiki/File:Jagalchi_Market_20200523_018.jpg'),
    ('yeosu-night-sea', '해상케이블카 야경', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Yeosu_harbour_2015-08-13(1).jpg', 'https://commons.wikimedia.org/wiki/File:Yeosu_harbour_2015-08-13(1).jpg'),
    ('yeosu-night-sea', '해산물/포차 투어', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Yeosu_harbour_2015-08-13(1).jpg', 'https://commons.wikimedia.org/wiki/File:Yeosu_harbour_2015-08-13(1).jpg'),
    ('yeosu-night-sea', '돌산 드라이브', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Hyangiram_hermitage_01.jpg', 'https://commons.wikimedia.org/wiki/File:Hyangiram_hermitage_01.jpg'),
    ('taean-anmyeondo', '꽃지 일몰 피크닉', 'https://tong.visitkorea.or.kr/cms/resource/06/2649006_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/whereToGo/locIntrdn/rgnContentsView.do?vcontsId=105248'),
    ('taean-anmyeondo', '숙소 바비큐/보드게임', 'https://tong.visitkorea.or.kr/cms/resource/70/2031770_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/whereToGo/locIntrdn/rgnContentsView.do?vcontsId=110628'),
    ('taean-anmyeondo', '해변 드라이브', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/태안해안국립공원_만리포_3.jpg', 'https://commons.wikimedia.org/wiki/File:태안해안국립공원_만리포_3.jpg'),
    ('tongyeong-geoje', '루지 단체 레이스', 'https://tong.visitkorea.or.kr/cms/resource/30/2488130_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=55669'),
    ('tongyeong-geoje', '한려수도 케이블카', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Korea-Tongyeong-Hallyeo_Waterway_Observation_Cable_Car-02.jpg', 'https://commons.wikimedia.org/wiki/File:Korea-Tongyeong-Hallyeo_Waterway_Observation_Cable_Car-02.jpg'),
    ('tongyeong-geoje', '거제 해안 드라이브', 'https://tong.visitkorea.or.kr/cms/resource/04/2612904_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=77569'),
    ('pohang-guryongpo', '스페이스워크 산책', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/SpaceWalk_(walkable_sculpture,_Pohang_2021)_Mutter_Genth_02.jpg', 'https://commons.wikimedia.org/wiki/File:SpaceWalk_(walkable_sculpture,_Pohang_2021)_Mutter_Genth_02.jpg'),
    ('pohang-guryongpo', '호미곶 일출 드라이브', 'https://commons.wikimedia.org/wiki/Special:Redirect/file/Pohang_Homigot2.jpg', 'https://commons.wikimedia.org/wiki/File:Pohang_Homigot2.jpg'),
    ('pohang-guryongpo', '죽도시장 해산물', 'https://tong.visitkorea.or.kr/cms/resource/12/3488112_image2_1.jpg', 'https://english.visitkorea.or.kr/svc/contents/contentsView.do?vcontsId=87881')
),
updated_activities as (
  select
    destinations.id,
    jsonb_agg(
      case
        when activity_media.item_name is null then activity.element
        else activity.element || jsonb_build_object(
          'imageUrl', activity_media.image_url,
          'imageSourceUrl', activity_media.image_source_url
        )
      end
      order by activity.ordinality
    ) as next_activities
  from public.travel_destinations destinations
  cross join lateral jsonb_array_elements(destinations.content->'activities')
    with ordinality as activity(element, ordinality)
  left join activity_media
    on activity_media.destination_id = destinations.id
    and activity_media.item_name = activity.element->>'name'
  group by destinations.id
)
update public.travel_destinations destinations
set content = jsonb_set(destinations.content, '{activities}', updated_activities.next_activities)
from updated_activities
where destinations.id = updated_activities.id;
