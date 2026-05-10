---
name: add-travel-region
description: "summer-vacation 여행 후보 웹앱에 신규 지역을 추가할 때 사용한다. 공개 출처 조사, 정적 fallback 데이터, Supabase 마이그레이션, 예상 경비, 교통안, 이미지/링크 검증, 빌드/배포 확인까지 한 번에 처리한다."
---

# Add Travel Region

Use this skill when adding a new destination/region candidate to this repo.

## Repo Targets

- Static fallback data: `src/data/activityFallback.ts`
- API merge logic: `src/lib/travelApi.ts`
- UI types/cards: `src/types/travel.ts`, `src/App.tsx`, `src/styles.css`
- Supabase seed/migration: `supabase/migrations/<timestamp>_add_<slug>_destination.sql`

## Workflow

1. **Collect sources**
   - Use public/official tourism pages first.
   - Use Wikimedia Commons or official/media pages for images.
   - Preserve source URLs. Do not rely on private/login-only booking data.

2. **Normalize the candidate**
   - Stable slug and id, e.g. `mukho-donghae`.
   - Include name, region, lat/lng, marker label, summary, recommended months/duration, tags.
   - Add `fit`, `sourceUrls`, `blogEvidenceUrls`, `reviewThemes`, `attractions`, `stays`, `activities`.
   - Every attraction should have `sourceUrl` and `mapUrl`; add representative images where available.

3. **Add cost estimate**
   - Use the app standard dates: `2026-06-26` to `2026-06-28`, `8` people, `2` nights.
   - Add cost lines for lodging, transport, rental/vehicle, and local costs.
   - Use broad realistic ranges and label them as estimates.
   - Keep Airbnb/Socar/Korail links as verification links; do not claim live availability.

4. **Write both data paths**
   - Add the region to `activityFallbackDestinations` so GitHub Pages shows it before DB migration is applied.
   - Add transport options to `activityFallbackTransportOptions`.
   - Add a Supabase migration with matching `travel_destinations`, `travel_transport_options`, and `costEstimate` JSON.
   - If DB connection is unavailable, still commit fallback + migration and report the DB blocker.

5. **Validate**
   - Run `npm run build`.
   - Verify the production bundle contains the new display name after deployment.
   - Keep UI changes scoped; do not refactor unrelated travel data.

## Final Check

Before finishing, confirm:

- New region appears in static fallback.
- New region has at least one transport option.
- New region has an 8-person per-person cost estimate.
- Build passes.
- Commit, push, and GitHub Pages deploy are checked when the user expects the live site updated.
