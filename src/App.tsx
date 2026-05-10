import {
  CalendarDays,
  Car,
  CheckCircle2,
  ExternalLink,
  Heart,
  Map,
  MapPin,
  MessageCircle,
  RefreshCw,
  Send,
  Train,
  Users,
  X,
} from "lucide-react";
import { useEffect, useMemo, useState } from "react";
import {
  fetchTripPlannerData,
  submitDestinationComment,
  submitTripPreference,
  toggleTripPreferenceLike,
} from "./lib/travelApi";
import { isSupabaseConfigured } from "./lib/supabase";
import type {
  DestinationComment,
  PreferenceFormState,
  TravelDateOption,
  TravelDestination,
  TravelTransportMode,
  TravelTransportOption,
  TripPreference,
} from "./types/travel";

const defaultPlannerData = {
  destinations: [] as TravelDestination[],
  dateOptions: [] as TravelDateOption[],
  transportOptions: [] as TravelTransportOption[],
  preferences: [] as TripPreference[],
  comments: [] as DestinationComment[],
};

const viewLabels = {
  ideas: "후보",
  map: "지도",
  vote: "투표판",
};

type ActiveView = keyof typeof viewLabels;

const voterTokenStorageKey = "summer-vacation-voter-token";

const getVoterToken = () => {
  const currentVoterToken = window.localStorage.getItem(voterTokenStorageKey);

  if (currentVoterToken !== null) {
    return currentVoterToken;
  }

  const nextVoterToken = window.crypto.randomUUID();
  window.localStorage.setItem(voterTokenStorageKey, nextVoterToken);

  return nextVoterToken;
};

const getTransportIcon = (mode: TravelTransportMode) => {
  if (mode === "car_only") {
    return Car;
  }

  return Train;
};

const getReviewLinks = (destination: TravelDestination, attractionName: string) => {
  const query = encodeURIComponent(`${destination.region} ${attractionName}`);

  return [
    {
      label: "네이버 리뷰",
      url: `https://map.naver.com/p/search/${query}`,
    },
    {
      label: "구글 리뷰",
      url: `https://www.google.com/maps/search/?api=1&query=${query}`,
    },
    {
      label: "카카오 리뷰",
      url: `https://map.kakao.com/?q=${query}`,
    },
  ];
};

const getMapPosition = (destination: TravelDestination) => {
  const minLatitude = 33.1;
  const maxLatitude = 38.6;
  const minLongitude = 124.4;
  const maxLongitude = 131.2;

  return {
    left: `${((destination.longitude - minLongitude) / (maxLongitude - minLongitude)) * 100}%`,
    top: `${(1 - (destination.latitude - minLatitude) / (maxLatitude - minLatitude)) * 100}%`,
  };
};

export const App = () => {
  const [plannerData, setPlannerData] = useState(defaultPlannerData);
  const [voterName, setVoterName] = useState("");
  const [voterToken, setVoterToken] = useState("");
  const [activeView, setActiveView] = useState<ActiveView>("ideas");
  const [selectedDestinationId, setSelectedDestinationId] = useState<string | null>(
    null,
  );
  const [preferenceForms, setPreferenceForms] = useState<
    Record<string, PreferenceFormState>
  >({});
  const [commentForms, setCommentForms] = useState<Record<string, string>>({});
  const [isLoading, setIsLoading] = useState(true);
  const [submittingKey, setSubmittingKey] = useState<string | null>(null);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const [successMessage, setSuccessMessage] = useState<string | null>(null);

  const transportOptionsByDestinationId = useMemo(() => {
    return plannerData.transportOptions.reduce<
      Record<string, TravelTransportOption[]>
    >((optionsByDestinationId, transportOption) => {
      optionsByDestinationId[transportOption.destination_id] = [
        ...(optionsByDestinationId[transportOption.destination_id] ?? []),
        transportOption,
      ];

      return optionsByDestinationId;
    }, {});
  }, [plannerData.transportOptions]);

  const preferencesByDestinationId = useMemo(() => {
    return plannerData.preferences.reduce<Record<string, TripPreference[]>>(
      (preferencesByDestination, preference) => {
        preferencesByDestination[preference.destination_id] = [
          ...(preferencesByDestination[preference.destination_id] ?? []),
          preference,
        ];

        return preferencesByDestination;
      },
      {},
    );
  }, [plannerData.preferences]);

  const commentsByDestinationId = useMemo(() => {
    return plannerData.comments.reduce<Record<string, DestinationComment[]>>(
      (commentsByDestination, comment) => {
        commentsByDestination[comment.destination_id] = [
          ...(commentsByDestination[comment.destination_id] ?? []),
          comment,
        ];

        return commentsByDestination;
      },
      {},
    );
  }, [plannerData.comments]);

  const sortedDestinations = useMemo(() => {
    return [...plannerData.destinations].sort((firstDestination, secondDestination) => {
      const firstVoteCount =
        preferencesByDestinationId[firstDestination.id]?.length ?? 0;
      const secondVoteCount =
        preferencesByDestinationId[secondDestination.id]?.length ?? 0;

      return secondVoteCount - firstVoteCount;
    });
  }, [plannerData.destinations, preferencesByDestinationId]);

  const selectedDestination = useMemo(() => {
    return (
      plannerData.destinations.find(
        (destination) => destination.id === selectedDestinationId,
      ) ?? null
    );
  }, [plannerData.destinations, selectedDestinationId]);

  const loadPlannerData = async () => {
    if (!isSupabaseConfigured) {
      setErrorMessage("Supabase 환경 변수가 설정되지 않았습니다.");
      setIsLoading(false);
      return;
    }

    setIsLoading(true);
    setErrorMessage(null);

    try {
      const nextPlannerData = await fetchTripPlannerData();

      setPlannerData(nextPlannerData);
      setPreferenceForms((currentForms) => {
        return nextPlannerData.destinations.reduce<Record<string, PreferenceFormState>>(
          (forms, destination) => {
            const destinationTransportOptions =
              nextPlannerData.transportOptions.filter(
                (transportOption) =>
                  transportOption.destination_id === destination.id,
              );
            const currentForm = currentForms[destination.id];

            forms[destination.id] = {
              dateOptionId:
                currentForm?.dateOptionId ?? nextPlannerData.dateOptions[0]?.id ?? "",
              transportOptionId:
                currentForm?.transportOptionId ??
                destinationTransportOptions[0]?.id ??
                "",
            };

            return forms;
          },
          {},
        );
      });
    } catch (error) {
      setErrorMessage(
        error instanceof Error
          ? error.message
          : "여행 데이터를 불러오지 못했습니다.",
      );
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    setVoterToken(getVoterToken());
    void loadPlannerData();
  }, []);

  const getCurrentVoterToken = () => {
    if (voterToken.length > 0) {
      return voterToken;
    }

    const nextVoterToken = getVoterToken();
    setVoterToken(nextVoterToken);

    return nextVoterToken;
  };

  const requireVoterName = () => {
    const trimmedVoterName = voterName.trim();

    if (trimmedVoterName.length === 0) {
      setErrorMessage("닉네임을 먼저 입력하세요.");
      return null;
    }

    return trimmedVoterName;
  };

  const handlePreferenceFieldChange = (
    destinationId: string,
    field: keyof PreferenceFormState,
    value: string,
  ) => {
    setPreferenceForms((currentForms) => ({
      ...currentForms,
      [destinationId]: {
        ...currentForms[destinationId],
        dateOptionId: plannerData.dateOptions[0]?.id ?? "",
        transportOptionId:
          transportOptionsByDestinationId[destinationId]?.[0]?.id ?? "",
        [field]: value,
      },
    }));
  };

  const handleSubmitPreference = async (destinationId: string) => {
    const trimmedVoterName = requireVoterName();
    const form = preferenceForms[destinationId];

    if (trimmedVoterName === null) {
      return;
    }

    if (
      form === undefined ||
      form.dateOptionId.length === 0 ||
      form.transportOptionId.length === 0
    ) {
      setErrorMessage("날짜와 이동 방식을 선택하세요.");
      return;
    }

    setSubmittingKey(`preference:${destinationId}`);
    setErrorMessage(null);
    setSuccessMessage(null);

    try {
      await submitTripPreference({
        destinationId,
        dateOptionId: form.dateOptionId,
        transportOptionId: form.transportOptionId,
        voterName: trimmedVoterName,
        voterToken: getCurrentVoterToken(),
      });
      await loadPlannerData();
      setSuccessMessage("선택이 저장되었습니다.");
    } catch (error) {
      setErrorMessage(
        error instanceof Error ? error.message : "선택 저장에 실패했습니다.",
      );
    } finally {
      setSubmittingKey(null);
    }
  };

  const handleLikePreference = async (preferenceId: string) => {
    setSubmittingKey(`like:${preferenceId}`);
    setErrorMessage(null);
    setSuccessMessage(null);

    try {
      await toggleTripPreferenceLike(preferenceId, getCurrentVoterToken());
      await loadPlannerData();
    } catch (error) {
      setErrorMessage(
        error instanceof Error ? error.message : "좋아요 저장에 실패했습니다.",
      );
    } finally {
      setSubmittingKey(null);
    }
  };

  const handleSubmitComment = async (destinationId: string) => {
    const trimmedVoterName = requireVoterName();
    const body = commentForms[destinationId]?.trim() ?? "";

    if (trimmedVoterName === null) {
      return;
    }

    if (body.length === 0) {
      setErrorMessage("댓글 내용을 입력하세요.");
      return;
    }

    setSubmittingKey(`comment:${destinationId}`);
    setErrorMessage(null);
    setSuccessMessage(null);

    try {
      await submitDestinationComment({
        destinationId,
        commenterName: trimmedVoterName,
        commenterToken: getCurrentVoterToken(),
        body,
      });
      setCommentForms((currentForms) => ({
        ...currentForms,
        [destinationId]: "",
      }));
      await loadPlannerData();
      setSuccessMessage("댓글이 저장되었습니다.");
    } catch (error) {
      setErrorMessage(
        error instanceof Error ? error.message : "댓글 저장에 실패했습니다.",
      );
    } finally {
      setSubmittingKey(null);
    }
  };

  const renderDestinationDetail = (destination: TravelDestination) => {
    const destinationTransportOptions =
      transportOptionsByDestinationId[destination.id] ?? [];
    const destinationPreferences =
      preferencesByDestinationId[destination.id] ?? [];
    const destinationComments = commentsByDestinationId[destination.id] ?? [];
    const preferenceForm = preferenceForms[destination.id] ?? {
      dateOptionId: plannerData.dateOptions[0]?.id ?? "",
      transportOptionId: destinationTransportOptions[0]?.id ?? "",
    };

    return (
      <div className="detail-grid">
        <section className="detail-main">
          {destination.main_image_url !== null ? (
            <img
              className="detail-image"
              src={destination.main_image_url}
              alt=""
            />
          ) : null}

          <div className="detail-section">
            <p className="detail-fit">{destination.content.fit}</p>
            <div className="meta-grid">
              <div>
                <span>추천 시기</span>
                <strong>{destination.recommended_months}</strong>
              </div>
              <div>
                <span>추천 일정</span>
                <strong>{destination.recommended_duration}</strong>
              </div>
              <div>
                <span>현재 선택</span>
                <strong>{destinationPreferences.length}명</strong>
              </div>
            </div>
          </div>

          <section className="detail-section">
            <h3>잠실 출발 교통안</h3>
            <div className="transport-list">
              {destinationTransportOptions.map((transportOption) => {
                const TransportIcon = getTransportIcon(transportOption.mode);

                return (
                  <article className="transport-card" key={transportOption.id}>
                    <div className="transport-heading">
                      <TransportIcon size={18} aria-hidden="true" />
                      <strong>{transportOption.label}</strong>
                    </div>
                    <p>{transportOption.route_steps.join(" → ")}</p>
                    <dl>
                      <div>
                        <dt>시간</dt>
                        <dd>{transportOption.estimated_time}</dd>
                      </div>
                      <div>
                        <dt>비용</dt>
                        <dd>{transportOption.estimated_cost}</dd>
                      </div>
                      {transportOption.requires_car ? (
                        <div>
                          <dt>렌트</dt>
                          <dd>
                            7-8인승 또는 차량 2대 기준 1일 약 12만-30만원대,
                            성수기 실시간 견적 필요
                          </dd>
                        </div>
                      ) : null}
                    </dl>
                    <p className="risk-note">{transportOption.risk_note}</p>
                  </article>
                );
              })}
            </div>
          </section>

          <section className="detail-section">
            <h3>관광지와 리뷰 근거</h3>
            <div className="item-grid">
              {(destination.content.attractions ?? []).map((attraction) => (
                <article className="mini-card" key={attraction.name}>
                  <span>{attraction.kind}</span>
                  <strong>{attraction.name}</strong>
                  <p>{attraction.description}</p>
                  <div className="link-row">
                    <a href={attraction.sourceUrl} target="_blank" rel="noreferrer">
                      출처 <ExternalLink size={13} aria-hidden="true" />
                    </a>
                    <a href={attraction.mapUrl} target="_blank" rel="noreferrer">
                      지도 <ExternalLink size={13} aria-hidden="true" />
                    </a>
                  </div>
                  <div className="review-source-row" aria-label="리뷰 출처">
                    {getReviewLinks(destination, attraction.name).map((reviewLink) => (
                      <a
                        href={reviewLink.url}
                        key={reviewLink.label}
                        target="_blank"
                        rel="noreferrer"
                      >
                        {reviewLink.label}
                      </a>
                    ))}
                  </div>
                </article>
              ))}
            </div>
            <div className="review-list">
              {(destination.content.reviewThemes ?? []).map((theme) => (
                <p key={theme}>{theme}</p>
              ))}
            </div>
          </section>

          <section className="detail-section">
            <h3>7-8명 숙소 후보</h3>
            <div className="item-grid">
              {(destination.content.stays ?? []).map((stay) => (
                <article className="mini-card" key={stay.name}>
                  <span>{stay.area}</span>
                  <strong>{stay.name}</strong>
                  <p>{stay.notes}</p>
                </article>
              ))}
            </div>
          </section>

          <section className="detail-section">
            <h3>핵심 액티비티</h3>
            <div className="activity-list">
              {(destination.content.activities ?? []).map((activity) => (
                <p key={activity.name}>
                  <strong>{activity.name}</strong>
                  <span>{activity.risk}</span>
                </p>
              ))}
            </div>
          </section>
        </section>

        <aside className="decision-panel">
          <section className="decision-box">
            <h3>내 선택 저장</h3>
            <label>
              <span>희망 날짜</span>
              <select
                value={preferenceForm.dateOptionId}
                onChange={(event) =>
                  handlePreferenceFieldChange(
                    destination.id,
                    "dateOptionId",
                    event.target.value,
                  )
                }
              >
                {plannerData.dateOptions.map((dateOption) => (
                  <option key={dateOption.id} value={dateOption.id}>
                    {dateOption.label}
                  </option>
                ))}
              </select>
            </label>
            <label>
              <span>이동 방식</span>
              <select
                value={preferenceForm.transportOptionId}
                onChange={(event) =>
                  handlePreferenceFieldChange(
                    destination.id,
                    "transportOptionId",
                    event.target.value,
                  )
                }
              >
                {destinationTransportOptions.map((transportOption) => (
                  <option key={transportOption.id} value={transportOption.id}>
                    {transportOption.label}
                  </option>
                ))}
              </select>
            </label>
            <button
              className="primary-button"
              type="button"
              disabled={submittingKey === `preference:${destination.id}`}
              onClick={() => void handleSubmitPreference(destination.id)}
            >
              <Send size={16} aria-hidden="true" />
              <span>
                {submittingKey === `preference:${destination.id}`
                  ? "저장 중"
                  : "선택 저장"}
              </span>
            </button>
          </section>

          <section className="decision-box">
            <h3>친구들 선택</h3>
            {destinationPreferences.length === 0 ? (
              <p className="quiet-text">아직 저장된 선택이 없습니다.</p>
            ) : (
              <div className="preference-list">
                {destinationPreferences.map((preference) => {
                  const dateOption = plannerData.dateOptions.find(
                    (option) => option.id === preference.date_option_id,
                  );
                  const transportOption = plannerData.transportOptions.find(
                    (option) => option.id === preference.transport_option_id,
                  );

                  return (
                    <article className="preference-item" key={preference.id}>
                      <div>
                        <strong>{preference.voter_name}</strong>
                        <span>{dateOption?.label ?? "날짜 미정"}</span>
                        <span>{transportOption?.label ?? "교통 미정"}</span>
                      </div>
                      <button
                        className="like-button"
                        type="button"
                        disabled={submittingKey === `like:${preference.id}`}
                        onClick={() => void handleLikePreference(preference.id)}
                      >
                        <Heart size={15} aria-hidden="true" />
                        {preference.like_count}
                      </button>
                    </article>
                  );
                })}
              </div>
            )}
          </section>

          <section className="decision-box">
            <h3>댓글</h3>
            <textarea
              value={commentForms[destination.id] ?? ""}
              onChange={(event) =>
                setCommentForms((currentForms) => ({
                  ...currentForms,
                  [destination.id]: event.target.value,
                }))
              }
              maxLength={700}
              placeholder="숙소, 일정, 걱정되는 점"
            />
            <button
              className="secondary-button"
              type="button"
              disabled={submittingKey === `comment:${destination.id}`}
              onClick={() => void handleSubmitComment(destination.id)}
            >
              <MessageCircle size={16} aria-hidden="true" />
              <span>댓글 저장</span>
            </button>
            <div className="comment-list">
              {destinationComments.map((comment) => (
                <article className="comment-item" key={comment.id}>
                  <strong>{comment.commenter_name}</strong>
                  <p>{comment.body}</p>
                </article>
              ))}
            </div>
          </section>
        </aside>
      </div>
    );
  };

  return (
    <main className="app-shell">
      <section className="top-bar" aria-labelledby="page-title">
        <div>
          <p className="eyebrow">Summer Vacation</p>
          <h1 id="page-title">바다 여행 투표판</h1>
          <p className="top-description">
            잠실 출발 기준으로 2박3일/3박4일 후보를 비교하고 친구별 날짜와
            이동 방식을 모읍니다.
          </p>
        </div>
        <button className="icon-button" type="button" onClick={loadPlannerData}>
          <RefreshCw size={18} aria-hidden="true" />
          <span>새로고침</span>
        </button>
      </section>

      <section className="control-panel" aria-label="참여 정보">
        <label className="name-field">
          <span>닉네임</span>
          <input
            value={voterName}
            onChange={(event) => setVoterName(event.target.value)}
            maxLength={40}
            placeholder="친구들이 알아볼 이름"
          />
        </label>
        <div className="status-cluster" aria-live="polite">
          {errorMessage !== null ? (
            <p className="status-message error">{errorMessage}</p>
          ) : null}
          {successMessage !== null ? (
            <p className="status-message success">
              <CheckCircle2 size={16} aria-hidden="true" />
              {successMessage}
            </p>
          ) : null}
        </div>
      </section>

      <nav className="view-tabs" aria-label="화면 선택">
        {(Object.keys(viewLabels) as ActiveView[]).map((view) => (
          <button
            className={activeView === view ? "active" : ""}
            key={view}
            type="button"
            onClick={() => setActiveView(view)}
          >
            {view === "ideas" ? <Users size={16} aria-hidden="true" /> : null}
            {view === "map" ? <Map size={16} aria-hidden="true" /> : null}
            {view === "vote" ? (
              <CalendarDays size={16} aria-hidden="true" />
            ) : null}
            {viewLabels[view]}
          </button>
        ))}
      </nav>

      {isLoading ? (
        <p className="empty-state">여행 데이터를 불러오는 중입니다.</p>
      ) : plannerData.destinations.length === 0 ? (
        <p className="empty-state">아직 여행 후보가 없습니다.</p>
      ) : (
        <section className="planner-layout">
          {(activeView === "ideas" || activeView === "vote") && (
            <section className="destination-list" aria-label="여행 후보 목록">
              {sortedDestinations.map((destination, index) => {
                const destinationPreferences =
                  preferencesByDestinationId[destination.id] ?? [];
                const destinationComments =
                  commentsByDestinationId[destination.id] ?? [];

                return (
                  <article className="destination-card" key={destination.id}>
                    {destination.main_image_url !== null ? (
                      <img
                        className="destination-image"
                        src={destination.main_image_url}
                        alt=""
                        loading="lazy"
                      />
                    ) : null}
                    <div className="destination-content">
                      <div className="destination-heading">
                        <div>
                          <p className="rank-label">#{index + 1}</p>
                          <h2>{destination.name}</h2>
                        </div>
                        <div className="vote-badge">
                          <Users size={15} aria-hidden="true" />
                          {destinationPreferences.length}
                        </div>
                      </div>
                      <p className="destination-region">
                        <MapPin size={15} aria-hidden="true" />
                        {destination.region}
                      </p>
                      <p className="destination-summary">{destination.summary}</p>
                      <div className="tag-row">
                        {destination.tags.map((tag) => (
                          <span key={tag}>{tag}</span>
                        ))}
                      </div>
                      <div className="card-meta-row">
                        <span>
                          <CalendarDays size={15} aria-hidden="true" />
                          {destination.recommended_duration}
                        </span>
                        <span>
                          <MessageCircle size={15} aria-hidden="true" />
                          {destinationComments.length}
                        </span>
                      </div>
                      <button
                        className="primary-button"
                        type="button"
                        onClick={() => setSelectedDestinationId(destination.id)}
                      >
                        <MapPin size={16} aria-hidden="true" />
                        <span>상세에서 선택하기</span>
                      </button>
                    </div>
                  </article>
                );
              })}
            </section>
          )}

          <aside className="map-panel" aria-label="대한민국 해안 후보 지도">
            <div className="map-header">
              <div>
                <p className="eyebrow">Korea Map</p>
                <h2>해안 후보 분포</h2>
              </div>
              <span>배지는 선택 인원</span>
            </div>
            <div className="korea-map">
              <div className="korea-shape" aria-hidden="true" />
              {plannerData.destinations.map((destination) => {
                const destinationPreferences =
                  preferencesByDestinationId[destination.id] ?? [];

                return (
                  <button
                    className="map-marker"
                    key={destination.id}
                    style={getMapPosition(destination)}
                    type="button"
                    onClick={() => setSelectedDestinationId(destination.id)}
                  >
                    <span>{destination.marker_label}</span>
                    <strong>{destinationPreferences.length}</strong>
                  </button>
                );
              })}
            </div>
          </aside>

          {activeView === "vote" ? (
            <section className="vote-dashboard" aria-label="전체 투표 현황">
              <div className="dashboard-section">
                <h2>목적지 순위</h2>
                {sortedDestinations.map((destination) => (
                  <div className="result-row" key={destination.id}>
                    <span>{destination.name}</span>
                    <strong>
                      {preferencesByDestinationId[destination.id]?.length ?? 0}명
                    </strong>
                  </div>
                ))}
              </div>
              <div className="dashboard-section">
                <h2>날짜 선호</h2>
                {plannerData.dateOptions.map((dateOption) => {
                  const voteCount = plannerData.preferences.filter(
                    (preference) => preference.date_option_id === dateOption.id,
                  ).length;

                  return (
                    <div className="result-row" key={dateOption.id}>
                      <span>{dateOption.label}</span>
                      <strong>{voteCount}명</strong>
                    </div>
                  );
                })}
              </div>
              <div className="dashboard-section">
                <h2>이동 방식 선호</h2>
                {["ktx_local", "car_only", "ktx_rental"].map((mode) => {
                  const voteCount = plannerData.preferences.filter(
                    (preference) =>
                      plannerData.transportOptions.find(
                        (transportOption) =>
                          transportOption.id ===
                            preference.transport_option_id &&
                          transportOption.mode === mode,
                      ) !== undefined,
                  ).length;

                  return (
                    <div className="result-row" key={mode}>
                      <span>
                        {mode === "ktx_local"
                          ? "KTX + 현지 이동"
                          : mode === "car_only"
                            ? "차량 직행"
                            : "KTX + 역 렌터카"}
                      </span>
                      <strong>{voteCount}명</strong>
                    </div>
                  );
                })}
              </div>
            </section>
          ) : null}
        </section>
      )}

      {selectedDestination !== null ? (
        <section
          className="detail-overlay"
          aria-label={`${selectedDestination.name} 상세`}
        >
          <div className="detail-shell">
            <header className="detail-topbar">
              <div>
                <p className="eyebrow">{selectedDestination.region}</p>
                <h2>{selectedDestination.name}</h2>
              </div>
              <button
                className="close-button"
                type="button"
                aria-label="상세 닫기"
                onClick={() => setSelectedDestinationId(null)}
              >
                <X size={20} aria-hidden="true" />
              </button>
            </header>
            {renderDestinationDetail(selectedDestination)}
          </div>
        </section>
      ) : null}
    </main>
  );
};
