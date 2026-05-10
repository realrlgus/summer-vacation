update public.travel_destinations
set
  main_image_url = 'https://tong.visitkorea.or.kr/cms/resource/05/3534505_image2_1.jpg',
  image_source_url = 'https://ontrip.kr/travel-guides/details/2711035',
  image_credit = '한국관광공사',
  content = jsonb_set(
    jsonb_set(
      jsonb_set(
        jsonb_set(
          jsonb_set(
            jsonb_set(
              jsonb_set(
                jsonb_set(
                  content,
                  '{attractions,0,imageUrl}',
                  to_jsonb('https://tong.visitkorea.or.kr/cms/resource/17/2742017_image2_1.jpg'::text),
                  true
                ),
                '{attractions,0,imageSourceUrl}',
                to_jsonb('https://ontrip.kr/travel-guides/details/2711035'::text),
                true
              ),
              '{attractions,1,imageUrl}',
              to_jsonb('https://commons.wikimedia.org/wiki/Special:Redirect/file/2016%EB%85%84%207%EC%9B%94%2030%EC%9D%BC%20See%26Sea%20DSC04008.jpg'::text),
              true
            ),
            '{attractions,1,imageSourceUrl}',
            to_jsonb('https://commons.wikimedia.org/wiki/File:2016%EB%85%84_7%EC%9B%94_30%EC%9D%BC_See%26Sea_DSC04008.jpg'::text),
            true
          ),
          '{attractions,2,imageUrl}',
          to_jsonb('https://tong.visitkorea.or.kr/cms/resource/55/3423355_image2_1.jpg'::text),
          true
        ),
        '{attractions,2,imageSourceUrl}',
        to_jsonb('https://ontrip.kr/travel-guides/details/129588'::text),
        true
      ),
      '{attractions,3,imageUrl}',
      to_jsonb('https://tong.visitkorea.or.kr/cms/resource/08/609108_image2_1.jpg'::text),
      true
    ),
    '{attractions,3,imageSourceUrl}',
    to_jsonb('https://ontrip.kr/travel-guides/details/125708'::text),
    true
  )
where id = 'mukho-donghae';

update public.travel_destinations
set content = jsonb_set(
  jsonb_set(
    jsonb_set(
      jsonb_set(
        jsonb_set(
          jsonb_set(
            content,
            '{activities,0,imageUrl}',
            to_jsonb('https://tong.visitkorea.or.kr/cms/resource/05/3534505_image2_1.jpg'::text),
            true
          ),
          '{activities,0,imageSourceUrl}',
          to_jsonb('https://ontrip.kr/travel-guides/details/2711035'::text),
          true
        ),
        '{activities,1,imageUrl}',
        to_jsonb('https://tong.visitkorea.or.kr/cms/resource/08/2678608_image2_1.jpg'::text),
        true
      ),
      '{activities,1,imageSourceUrl}',
      to_jsonb('https://ontrip.kr/travel-guides/details/129588'::text),
      true
    ),
    '{activities,2,imageUrl}',
    to_jsonb('https://tong.visitkorea.or.kr/cms/resource/15/609115_image2_1.jpg'::text),
    true
  ),
  '{activities,2,imageSourceUrl}',
  to_jsonb('https://ontrip.kr/travel-guides/details/125708'::text),
  true
)
where id = 'mukho-donghae';
