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
  Trash2,
  Users,
  X,
} from "lucide-react";
import L from "leaflet";
import { useEffect, useMemo, useRef, useState } from "react";
import {
  deleteDestinationComment,
  deleteScheduleComment,
  deleteTripPreference,
  fetchTripPlannerData,
  getScheduleCommentBody,
  isScheduleComment,
  submitDestinationComment,
  submitScheduleComment,
  submitTripPreference,
  toggleTripPreferenceLike,
} from "./lib/travelApi";
import { isSupabaseConfigured } from "./lib/supabase";
import type {
  DestinationComment,
  PreferenceFormState,
  TravelCostEstimate,
  TravelCostLine,
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

const minTravelDate = "2026-06-01";
const maxTravelDate = "2026-09-30";
const defaultStartDate = "2026-06-26";
const defaultEndDate = "2026-06-28";
const voterTokenStorageKey = "summer-vacation-device-token";
const voterNameStorageKey = "summer-vacation-voter-name";
const wonFormatter = new Intl.NumberFormat("ko-KR");
const scheduleCommentPreviewCount = 3;
const commentTimeFormatter = new Intl.DateTimeFormat("ko-KR", {
  month: "numeric",
  day: "numeric",
  hour: "2-digit",
  minute: "2-digit",
});

const getVoterToken = () => {
  const currentVoterToken = window.localStorage.getItem(voterTokenStorageKey);

  if (currentVoterToken !== null) {
    return currentVoterToken;
  }

  const legacyVoterToken = window.localStorage.getItem("summer-vacation-voter-token");
  const nextVoterToken = legacyVoterToken ?? window.crypto.randomUUID();
  window.localStorage.setItem(voterTokenStorageKey, nextVoterToken);
  window.localStorage.removeItem("summer-vacation-voter-token");

  return nextVoterToken;
};

const getStoredVoterName = () => {
  return window.localStorage.getItem(voterNameStorageKey) ?? "";
};

const getTransportIcon = (mode: TravelTransportMode) => {
  if (mode === "car_only") {
    return Car;
  }

  return Train;
};

const formatWonRange = (minAmount: number, maxAmount: number) => {
  if (minAmount === maxAmount) {
    return `${wonFormatter.format(minAmount)}원`;
  }

  return `${wonFormatter.format(minAmount)}-${wonFormatter.format(maxAmount)}원`;
};

const getCostEstimateTotal = (costEstimate: TravelCostEstimate) => {
  return costEstimate.lines.reduce(
    (total, line) => ({
      minAmount: total.minAmount + line.minAmount,
      maxAmount: total.maxAmount + line.maxAmount,
    }),
    { minAmount: 0, maxAmount: 0 },
  );
};

const roundUpToHundred = (amount: number) => {
  return Math.ceil(amount / 100) * 100;
};

const getPerPersonCostLabel = (costEstimate: TravelCostEstimate) => {
  const total = getCostEstimateTotal(costEstimate);
  const perPersonMin = roundUpToHundred(
    total.minAmount / costEstimate.baseDates.people,
  );
  const perPersonMax = roundUpToHundred(
    total.maxAmount / costEstimate.baseDates.people,
  );

  return formatWonRange(perPersonMin, perPersonMax);
};

const formatCommentTime = (createdAt: string) => {
  return commentTimeFormatter.format(new Date(createdAt));
};

const getCostLineIcon = (line: TravelCostLine) => {
  if (line.category.includes("교통") || line.category.includes("KTX")) {
    return Train;
  }

  if (line.category.includes("렌트") || line.category.includes("차량")) {
    return Car;
  }

  return CalendarDays;
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

const getAttractionReviewLinks = (
  destination: TravelDestination,
  attraction: { name: string; naverUrl?: string; googleUrl?: string; kakaoUrl?: string },
) => {
  return [
    {
      label: "네이버 리뷰",
      url: attraction.naverUrl,
    },
    {
      label: "구글 리뷰",
      url: attraction.googleUrl,
    },
    {
      label: "카카오 리뷰",
      url: attraction.kakaoUrl,
    },
  ].map((reviewLink) => ({
    ...reviewLink,
    url:
      reviewLink.url ??
      getReviewLinks(destination, attraction.name).find(
        (fallbackLink) => fallbackLink.label === reviewLink.label,
      )?.url ??
      "#",
  }));
};

type KoreaMapProps = {
  destinations: TravelDestination[];
  preferencesByDestinationId: Record<string, TripPreference[]>;
  onSelectDestination: (destinationId: string) => void;
};

const KoreaMap = ({
  destinations,
  preferencesByDestinationId,
  onSelectDestination,
}: KoreaMapProps) => {
  const mapContainerRef = useRef<HTMLDivElement | null>(null);
  const mapRef = useRef<L.Map | null>(null);
  const markerLayerRef = useRef<L.LayerGroup | null>(null);

  useEffect(() => {
    if (mapContainerRef.current === null || mapRef.current !== null) {
      return;
    }

    mapRef.current = L.map(mapContainerRef.current, {
      center: [36.35, 127.95],
      zoom: 7,
      minZoom: 6,
      maxZoom: 12,
      scrollWheelZoom: false,
    });

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution:
        '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
    }).addTo(mapRef.current);

    markerLayerRef.current = L.layerGroup().addTo(mapRef.current);

    return () => {
      mapRef.current?.remove();
      mapRef.current = null;
      markerLayerRef.current = null;
    };
  }, []);

  useEffect(() => {
    if (mapRef.current === null || markerLayerRef.current === null) {
      return;
    }

    markerLayerRef.current.clearLayers();

    const bounds = L.latLngBounds([]);

    destinations.forEach((destination) => {
      const voteCount = preferencesByDestinationId[destination.id]?.length ?? 0;
      const marker = L.marker([destination.latitude, destination.longitude], {
        icon: L.divIcon({
          className: "destination-map-icon",
          html: `<span>${destination.marker_label}</span><strong>${voteCount}</strong>`,
          iconAnchor: [24, 20],
        }),
      });

      marker
        .bindTooltip(destination.name, {
          direction: "top",
          offset: [0, -12],
        })
        .on("click", () => onSelectDestination(destination.id))
        .addTo(markerLayerRef.current as L.LayerGroup);

      bounds.extend([destination.latitude, destination.longitude]);
    });

    if (bounds.isValid()) {
      mapRef.current.fitBounds(bounds, {
        padding: [32, 32],
        maxZoom: 7,
      });
    }
  }, [destinations, onSelectDestination, preferencesByDestinationId]);

  return <div className="korea-map" ref={mapContainerRef} />;
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
  const [scheduleCommentForm, setScheduleCommentForm] = useState("");
  const [isScheduleCommentsExpanded, setIsScheduleCommentsExpanded] =
    useState(false);
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
    return plannerData.comments
      .filter((comment) => !isScheduleComment(comment))
      .reduce<Record<string, DestinationComment[]>>(
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

  const scheduleComments = useMemo(() => {
    return plannerData.comments.filter(isScheduleComment);
  }, [plannerData.comments]);

  const visibleScheduleComments = useMemo(() => {
    if (isScheduleCommentsExpanded) {
      return scheduleComments;
    }

    return scheduleComments.slice(0, scheduleCommentPreviewCount);
  }, [isScheduleCommentsExpanded, scheduleComments]);

  const shouldShowScheduleCommentToggle =
    scheduleComments.length > scheduleCommentPreviewCount;

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

  const loadPlannerData = async (viewerToken = getCurrentVoterToken()) => {
    if (!isSupabaseConfigured) {
      setErrorMessage("Supabase 환경 변수가 설정되지 않았습니다.");
      setIsLoading(false);
      return;
    }

    setIsLoading(true);
    setErrorMessage(null);

    try {
      const nextPlannerData = await fetchTripPlannerData(viewerToken);

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
              startDate: currentForm?.startDate ?? defaultStartDate,
              endDate: currentForm?.endDate ?? defaultEndDate,
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
    const nextVoterToken = getVoterToken();
    setVoterToken(nextVoterToken);
    setVoterName(getStoredVoterName());
    void loadPlannerData(nextVoterToken);
  }, []);

  useEffect(() => {
    window.localStorage.setItem(voterNameStorageKey, voterName);
  }, [voterName]);

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
        startDate: currentForms[destinationId]?.startDate ?? defaultStartDate,
        endDate: currentForms[destinationId]?.endDate ?? defaultEndDate,
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
      form.startDate.length === 0 ||
      form.endDate.length === 0 ||
      form.transportOptionId.length === 0
    ) {
      setErrorMessage("날짜와 이동 방식을 선택하세요.");
      return;
    }

    const destination = plannerData.destinations.find(
      (plannerDestination) => plannerDestination.id === destinationId,
    );

    if (destination?.isStaticFallback === true) {
      setErrorMessage(
        "이 후보는 화면에 먼저 추가된 상태입니다. Supabase 데이터 반영 후 투표 저장이 가능합니다.",
      );
      return;
    }

    const startDate = new Date(`${form.startDate}T00:00:00`);
    const endDate = new Date(`${form.endDate}T00:00:00`);
    const nights = Math.round(
      (endDate.getTime() - startDate.getTime()) / (1000 * 60 * 60 * 24),
    );
    const includesWeekend = Array.from({ length: nights + 1 }).some((_, index) => {
      const date = new Date(startDate);
      date.setDate(startDate.getDate() + index);
      return date.getDay() === 0 || date.getDay() === 6;
    });

    if (form.startDate < minTravelDate || form.endDate > maxTravelDate) {
      setErrorMessage("여행 날짜는 2026년 6월 1일부터 9월 30일 사이여야 합니다.");
      return;
    }

    if (![2, 3].includes(nights)) {
      setErrorMessage("2박3일 또는 3박4일 일정만 저장할 수 있습니다.");
      return;
    }

    if (!includesWeekend) {
      setErrorMessage("주말이 포함된 날짜를 선택하세요.");
      return;
    }

    setSubmittingKey(`preference:${destinationId}`);
    setErrorMessage(null);
    setSuccessMessage(null);

    try {
      await submitTripPreference({
        destinationId,
        startDate: form.startDate,
        endDate: form.endDate,
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

  const handleDeletePreference = async (preferenceId: string) => {
    setSubmittingKey(`delete-preference:${preferenceId}`);
    setErrorMessage(null);
    setSuccessMessage(null);

    try {
      const isDeleted = await deleteTripPreference(
        preferenceId,
        getCurrentVoterToken(),
      );

      if (!isDeleted) {
        setErrorMessage("내가 저장한 선택만 지울 수 있습니다.");
        return;
      }

      await loadPlannerData();
      setSuccessMessage("선택이 삭제되었습니다.");
    } catch (error) {
      setErrorMessage(
        error instanceof Error ? error.message : "선택 삭제에 실패했습니다.",
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

  const handleSubmitScheduleComment = async () => {
    const trimmedVoterName = requireVoterName();
    const body = scheduleCommentForm.trim();

    if (trimmedVoterName === null) {
      return;
    }

    if (body.length === 0) {
      setErrorMessage("일정 댓글 내용을 입력하세요.");
      return;
    }

    setSubmittingKey("schedule-comment");
    setErrorMessage(null);
    setSuccessMessage(null);

    try {
      await submitScheduleComment({
        commenterName: trimmedVoterName,
        commenterToken: getCurrentVoterToken(),
        body,
      });
      setScheduleCommentForm("");
      await loadPlannerData();
      setSuccessMessage("일정 댓글이 저장되었습니다.");
    } catch (error) {
      setErrorMessage(
        error instanceof Error ? error.message : "일정 댓글 저장에 실패했습니다.",
      );
    } finally {
      setSubmittingKey(null);
    }
  };

  const handleDeleteScheduleComment = async (commentId: string) => {
    setSubmittingKey(`delete-schedule-comment:${commentId}`);
    setErrorMessage(null);
    setSuccessMessage(null);

    try {
      const isDeleted = await deleteScheduleComment(
        commentId,
        getCurrentVoterToken(),
      );

      if (!isDeleted) {
        setErrorMessage("내가 쓴 일정 댓글만 지울 수 있습니다.");
        return;
      }

      await loadPlannerData();
      setSuccessMessage("일정 댓글이 삭제되었습니다.");
    } catch (error) {
      setErrorMessage(
        error instanceof Error ? error.message : "일정 댓글 삭제에 실패했습니다.",
      );
    } finally {
      setSubmittingKey(null);
    }
  };

  const handleDeleteComment = async (commentId: string) => {
    setSubmittingKey(`delete-comment:${commentId}`);
    setErrorMessage(null);
    setSuccessMessage(null);

    try {
      const isDeleted = await deleteDestinationComment(
        commentId,
        getCurrentVoterToken(),
      );

      if (!isDeleted) {
        setErrorMessage("내가 쓴 댓글만 지울 수 있습니다.");
        return;
      }

      await loadPlannerData();
      setSuccessMessage("댓글이 삭제되었습니다.");
    } catch (error) {
      setErrorMessage(
        error instanceof Error ? error.message : "댓글 삭제에 실패했습니다.",
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
      startDate: defaultStartDate,
      endDate: defaultEndDate,
      transportOptionId: destinationTransportOptions[0]?.id ?? "",
    };
    const costEstimate = destination.content.costEstimate;

    return (
      <div className="detail-grid">
        <section className="detail-main">
          {destination.main_image_url !== null ? (
            <figure className="detail-media">
              <img
                className="detail-image"
                src={destination.main_image_url}
                alt=""
              />
              {destination.image_source_url !== null ? (
                <a
                  className="image-credit-link"
                  href={destination.image_source_url}
                  target="_blank"
                  rel="noreferrer"
                >
                  사진 출처 · {destination.image_credit ?? "source"}
                  <ExternalLink size={13} aria-hidden="true" />
                </a>
              ) : null}
            </figure>
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

          {costEstimate !== undefined ? (
            <section className="detail-section cost-section">
              <div className="section-heading-row">
                <div>
                  <p className="eyebrow">
                    {costEstimate.baseDates.startDate} -{" "}
                    {costEstimate.baseDates.endDate}
                  </p>
                  <h3>6월 26-28일 예상 비용</h3>
                </div>
                <span>{costEstimate.baseDates.people}명 기준</span>
              </div>
              <div className="cost-summary-grid">
                {(() => {
                  const total = getCostEstimateTotal(costEstimate);

                  return (
                    <>
                      <div>
                        <span>총 예상</span>
                        <strong>
                          {formatWonRange(total.minAmount, total.maxAmount)}
                        </strong>
                      </div>
                      <div>
                        <span>1인 예상</span>
                        <strong>
                          {formatWonRange(
                            roundUpToHundred(
                              total.minAmount / costEstimate.baseDates.people,
                            ),
                            roundUpToHundred(
                              total.maxAmount / costEstimate.baseDates.people,
                            ),
                          )}
                        </strong>
                      </div>
                    </>
                  );
                })()}
              </div>
              <div className="cost-line-list">
                {costEstimate.lines.map((line) => {
                  const CostIcon = getCostLineIcon(line);

                  return (
                    <article className="cost-line" key={`${line.category}-${line.label}`}>
                      <CostIcon size={17} aria-hidden="true" />
                      <div>
                        <span>{line.category}</span>
                        <strong>{line.label}</strong>
                        <p>{line.note}</p>
                      </div>
                      <strong>{formatWonRange(line.minAmount, line.maxAmount)}</strong>
                    </article>
                  );
                })}
              </div>
              <div className="link-row">
                {costEstimate.sourceUrls.map((url, index) => (
                  <a href={url} key={url} target="_blank" rel="noreferrer">
                    비용 출처 {index + 1}
                    <ExternalLink size={13} aria-hidden="true" />
                  </a>
                ))}
              </div>
            </section>
          ) : null}

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
                  {attraction.imageUrl !== undefined ? (
                    <img
                      className="mini-card-image"
                      src={attraction.imageUrl}
                      alt=""
                      loading="lazy"
                    />
                  ) : null}
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
                    {getAttractionReviewLinks(destination, attraction).map(
                      (reviewLink) => (
                        <a
                          href={reviewLink.url}
                          key={reviewLink.label}
                          target="_blank"
                          rel="noreferrer"
                        >
                          {reviewLink.label}
                        </a>
                      ),
                    )}
                  </div>
                </article>
              ))}
            </div>
            <div className="review-list">
              {(destination.content.reviewThemes ?? []).map((theme) => (
                <p key={theme}>{theme}</p>
              ))}
            </div>
            {(destination.content.blogEvidenceUrls ?? []).length > 0 ? (
              <div className="evidence-link-box">
                <strong>네이버 블로그 참고 글</strong>
                <div className="link-row">
                  {(destination.content.blogEvidenceUrls ?? []).map((url, index) => (
                    <a href={url} key={url} target="_blank" rel="noreferrer">
                      블로그 {index + 1}
                      <ExternalLink size={13} aria-hidden="true" />
                    </a>
                  ))}
                </div>
              </div>
            ) : null}
          </section>

          <section className="detail-section">
            <h3>7-8명 Airbnb 숙소 검색</h3>
            <div className="item-grid">
              {(destination.content.stays ?? []).map((stay) => (
                <article className="mini-card" key={stay.name}>
                  <span>{stay.area}</span>
                  <strong>{stay.name}</strong>
                  <p>{stay.notes}</p>
                  <div className="link-row">
                    {stay.airbnbUrl !== undefined ? (
                      <a href={stay.airbnbUrl} target="_blank" rel="noreferrer">
                        Airbnb 8인 검색
                        <ExternalLink size={13} aria-hidden="true" />
                      </a>
                    ) : null}
                    {(stay.sourceUrls ?? []).map((url, index) => (
                      <a href={url} key={url} target="_blank" rel="noreferrer">
                        숙소 근거 {index + 1}
                        <ExternalLink size={13} aria-hidden="true" />
                      </a>
                    ))}
                  </div>
                </article>
              ))}
            </div>
          </section>

          <section className="detail-section">
            <h3>핵심 액티비티</h3>
            <div className="activity-list">
              {(destination.content.activities ?? []).map((activity) => (
                <article className="activity-card" key={activity.name}>
                  {activity.imageUrl !== undefined ? (
                    <img
                      className="activity-card-image"
                      src={activity.imageUrl}
                      alt=""
                      loading="lazy"
                    />
                  ) : null}
                  <div>
                    <strong>{activity.name}</strong>
                    <span>{activity.risk}</span>
                  </div>
                </article>
              ))}
            </div>
          </section>
        </section>

        <aside className="decision-panel">
          {costEstimate !== undefined ? (
            <section className="decision-box trip-cost-summary">
              <h3>여행 경비</h3>
              {destination.isStaticFallback === true ? (
                <p className="fallback-note">DB 반영 전 임시 표시 후보</p>
              ) : null}
              {(() => {
                const total = getCostEstimateTotal(costEstimate);
                const perPersonMin = roundUpToHundred(
                  total.minAmount / costEstimate.baseDates.people,
                );
                const perPersonMax = roundUpToHundred(
                  total.maxAmount / costEstimate.baseDates.people,
                );

                return (
                  <>
                    <div className="trip-cost-amount">
                      <span>8인 기준</span>
                      <strong>
                        인당 {formatWonRange(perPersonMin, perPersonMax)}
                      </strong>
                    </div>
                    <p>
                      총 {formatWonRange(total.minAmount, total.maxAmount)} ·
                      숙소, 장거리 이동, 렌트/현지 이동, 대표 액티비티 버퍼
                    </p>
                  </>
                );
              })()}
            </section>
          ) : null}

          <section className="decision-box">
            <h3>내 선택 저장</h3>
            {destination.isStaticFallback === true ? (
              <p className="date-helper">
                이 후보는 DB 반영 전이라 지금은 비교만 가능합니다.
              </p>
            ) : null}
            <div className="calendar-range">
              <label>
                <span>출발일</span>
                <input
                  type="date"
                  min={minTravelDate}
                  max={maxTravelDate}
                  value={preferenceForm.startDate}
                  onChange={(event) =>
                    handlePreferenceFieldChange(
                      destination.id,
                      "startDate",
                      event.target.value,
                    )
                  }
                />
              </label>
              <label>
                <span>도착일</span>
                <input
                  type="date"
                  min={minTravelDate}
                  max={maxTravelDate}
                  value={preferenceForm.endDate}
                  onChange={(event) =>
                    handlePreferenceFieldChange(
                      destination.id,
                      "endDate",
                      event.target.value,
                    )
                  }
                />
              </label>
            </div>
            <p className="date-helper">6-9월 사이, 주말 포함 2박3일 또는 3박4일</p>
            <div className="transport-picker" role="radiogroup" aria-label="이동 방식">
              <span>이동 방식</span>
              <div className="transport-segment">
                {destinationTransportOptions.map((transportOption) => {
                  const isSelected =
                    preferenceForm.transportOptionId === transportOption.id;

                  return (
                    <button
                      className={isSelected ? "active" : ""}
                      key={transportOption.id}
                      type="button"
                      role="radio"
                      aria-checked={isSelected}
                      onClick={() =>
                        handlePreferenceFieldChange(
                          destination.id,
                          "transportOptionId",
                          transportOption.id,
                        )
                      }
                    >
                      <strong>{transportOption.label}</strong>
                      <span>{transportOption.estimated_time}</span>
                    </button>
                  );
                })}
              </div>
            </div>
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
                  const transportOption = plannerData.transportOptions.find(
                    (option) => option.id === preference.transport_option_id,
                  );
                  const dateLabel =
                    preference.start_date !== null && preference.end_date !== null
                      ? `${preference.start_date} - ${preference.end_date}`
                      : "날짜 미정";

                  return (
                    <article className="preference-item" key={preference.id}>
                      <div>
                        <strong>{preference.voter_name}</strong>
                        <span>{dateLabel}</span>
                        <span>{transportOption?.label ?? "교통 미정"}</span>
                      </div>
                      <div className="item-actions">
                        <button
                          className="like-button"
                          type="button"
                          disabled={submittingKey === `like:${preference.id}`}
                          onClick={() => void handleLikePreference(preference.id)}
                        >
                          <Heart size={15} aria-hidden="true" />
                          {preference.like_count}
                        </button>
                        {preference.is_owner === true ? (
                          <button
                            className="delete-button"
                            type="button"
                            aria-label="내 선택 삭제"
                            disabled={
                              submittingKey === `delete-preference:${preference.id}`
                            }
                            onClick={() =>
                              void handleDeletePreference(preference.id)
                            }
                          >
                            <Trash2 size={15} aria-hidden="true" />
                          </button>
                        ) : null}
                      </div>
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
                  <div className="comment-heading">
                    <div className="comment-meta">
                      <strong>{comment.commenter_name}</strong>
                      <time dateTime={comment.created_at}>
                        {formatCommentTime(comment.created_at)}
                      </time>
                    </div>
                    {comment.is_owner === true ? (
                      <button
                        className="delete-button"
                        type="button"
                        aria-label="내 댓글 삭제"
                        disabled={submittingKey === `delete-comment:${comment.id}`}
                        onClick={() => void handleDeleteComment(comment.id)}
                      >
                        <Trash2 size={15} aria-hidden="true" />
                      </button>
                    ) : null}
                  </div>
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
        <button
          className="icon-button"
          type="button"
          onClick={() => void loadPlannerData()}
        >
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
        <section
          className={`planner-layout ${
            activeView === "vote" ? "vote-layout" : ""
          }`}
        >
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
                {Object.entries(
                  plannerData.preferences.reduce<Record<string, number>>(
                    (dateCounts, preference) => {
                      const dateLabel =
                        preference.start_date !== null &&
                        preference.end_date !== null
                          ? `${preference.start_date} - ${preference.end_date}`
                          : "날짜 미정";

                      dateCounts[dateLabel] = (dateCounts[dateLabel] ?? 0) + 1;
                      return dateCounts;
                    },
                    {},
                  ),
                ).map(([dateLabel, voteCount]) => (
                  <div className="result-row" key={dateLabel}>
                    <span>{dateLabel}</span>
                    <strong>{voteCount}명</strong>
                  </div>
                ))}
                {plannerData.preferences.length === 0 ? (
                  <p className="quiet-text">아직 저장된 날짜가 없습니다.</p>
                ) : null}
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
                      <div className="destination-media">
                        <img
                          className="destination-image"
                          src={destination.main_image_url}
                          alt=""
                          loading="lazy"
                        />
                        {destination.image_source_url !== null ? (
                          <a
                            className="image-credit-link"
                            href={destination.image_source_url}
                            target="_blank"
                            rel="noreferrer"
                          >
                            {destination.image_credit ?? "source"}
                            <ExternalLink size={13} aria-hidden="true" />
                          </a>
                        ) : null}
                      </div>
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
                      {destination.content.costEstimate !== undefined ? (
                        <div className="card-cost-row">
                          <span>예상 경비</span>
                          <strong>
                            인당{" "}
                            {getPerPersonCostLabel(
                              destination.content.costEstimate,
                            )}
                          </strong>
                        </div>
                      ) : null}
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
            <KoreaMap
              destinations={plannerData.destinations}
              preferencesByDestinationId={preferencesByDestinationId}
              onSelectDestination={setSelectedDestinationId}
            />
          </aside>
        </section>
      )}

      <section className="schedule-comment-panel" aria-label="전체 일정 댓글">
        <div className="schedule-comment-header">
          <div>
            <p className="eyebrow">Schedule Talk</p>
            <h2>전체 일정 조정</h2>
          </div>
          <span>{scheduleComments.length}개</span>
        </div>
        <div className="schedule-comment-list">
          {scheduleComments.length === 0 ? (
            <p className="quiet-text">아직 전체 일정 댓글이 없습니다.</p>
          ) : (
            visibleScheduleComments.map((comment) => (
              <article className="comment-item" key={comment.id}>
                <div className="comment-heading">
                  <div className="comment-meta">
                    <strong>{comment.commenter_name}</strong>
                    <time dateTime={comment.created_at}>
                      {formatCommentTime(comment.created_at)}
                    </time>
                  </div>
                  {comment.is_owner === true ? (
                    <button
                      className="delete-button"
                      type="button"
                      aria-label="내 일정 댓글 삭제"
                      disabled={
                        submittingKey === `delete-schedule-comment:${comment.id}`
                      }
                      onClick={() => void handleDeleteScheduleComment(comment.id)}
                    >
                      <Trash2 size={15} aria-hidden="true" />
                    </button>
                  ) : null}
                </div>
                <p>{getScheduleCommentBody(comment.body)}</p>
              </article>
            ))
          )}
        </div>
        {shouldShowScheduleCommentToggle ? (
          <button
            className="comment-toggle-button"
            type="button"
            onClick={() =>
              setIsScheduleCommentsExpanded(
                (currentIsExpanded) => !currentIsExpanded,
              )
            }
          >
            {isScheduleCommentsExpanded
              ? "접기"
              : `댓글 ${scheduleComments.length - scheduleCommentPreviewCount}개 더 보기`}
          </button>
        ) : null}
        <div className="schedule-comment-editor">
          <textarea
            value={scheduleCommentForm}
            onChange={(event) => setScheduleCommentForm(event.target.value)}
            maxLength={650}
            placeholder="출발 시간, 숙소 기준, 예산, 일정 조정 의견"
          />
          <button
            className="secondary-button"
            type="button"
            disabled={submittingKey === "schedule-comment"}
            onClick={() => void handleSubmitScheduleComment()}
          >
            <MessageCircle size={16} aria-hidden="true" />
            <span>
              {submittingKey === "schedule-comment" ? "저장 중" : "댓글 남기기"}
            </span>
          </button>
        </div>
      </section>

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
