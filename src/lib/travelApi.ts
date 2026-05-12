import { supabase } from "./supabase";
import {
  activityFallbackDestinations,
  activityFallbackTransportOptions,
  costEstimateFallbacks,
} from "../data/activityFallback";
import type {
  DestinationComment,
  TravelDateOption,
  TravelDestination,
  TravelTransportOption,
  TripPlannerData,
  TripPreference,
} from "../types/travel";

const requireSupabase = () => {
  if (supabase === null) {
    throw new Error("Supabase 환경 변수가 설정되지 않았습니다.");
  }

  return supabase;
};

export const scheduleCommentMarker = "__GLOBAL_SCHEDULE__::";
const scheduleCommentDestinationId = "busan-haeundae-gwangalli";
const staticFallbackPreferenceStorageKey =
  "summer-vacation-static-fallback-preferences";

type StaticFallbackPreference = {
  id: string;
  destination_id: string;
  start_date: string;
  end_date: string;
  transport_option_id: string;
  voter_name: string;
  voter_token: string;
  liker_tokens: string[];
  created_at: string;
  updated_at: string;
};

const readStaticFallbackPreferences = (): StaticFallbackPreference[] => {
  const rawPreferences = window.localStorage.getItem(
    staticFallbackPreferenceStorageKey,
  );

  if (rawPreferences === null) {
    return [];
  }

  try {
    const parsedPreferences = JSON.parse(rawPreferences);

    if (!Array.isArray(parsedPreferences)) {
      return [];
    }

    return parsedPreferences.filter(
      (preference): preference is StaticFallbackPreference =>
        typeof preference?.id === "string" &&
        typeof preference.destination_id === "string" &&
        typeof preference.start_date === "string" &&
        typeof preference.end_date === "string" &&
        typeof preference.transport_option_id === "string" &&
        typeof preference.voter_name === "string" &&
        typeof preference.voter_token === "string" &&
        Array.isArray(preference.liker_tokens) &&
        typeof preference.created_at === "string" &&
        typeof preference.updated_at === "string",
    );
  } catch {
    return [];
  }
};

const writeStaticFallbackPreferences = (
  preferences: StaticFallbackPreference[],
) => {
  window.localStorage.setItem(
    staticFallbackPreferenceStorageKey,
    JSON.stringify(preferences),
  );
};

const toTripPreference = (
  preference: StaticFallbackPreference,
  viewerToken: string,
): TripPreference => ({
  id: preference.id,
  destination_id: preference.destination_id,
  date_option_id: null,
  start_date: preference.start_date,
  end_date: preference.end_date,
  transport_option_id: preference.transport_option_id,
  voter_name: preference.voter_name,
  like_count: preference.liker_tokens.length,
  is_owner: preference.voter_token === viewerToken,
  created_at: preference.created_at,
  updated_at: preference.updated_at,
  isLocalFallback: true,
});

const getStaticFallbackTripPreferences = (
  viewerToken: string,
  destinationIds: Set<string>,
) => {
  return readStaticFallbackPreferences()
    .filter((preference) => destinationIds.has(preference.destination_id))
    .map((preference) => toTripPreference(preference, viewerToken));
};

export const isScheduleComment = (comment: DestinationComment) => {
  return (
    comment.destination_id === scheduleCommentDestinationId &&
    comment.body.startsWith(scheduleCommentMarker)
  );
};

export const getScheduleCommentBody = (body: string) => {
  if (!body.startsWith(scheduleCommentMarker)) {
    return body;
  }

  return body.slice(scheduleCommentMarker.length);
};

const mergeActivityFallback = (
  plannerData: TripPlannerData,
  viewerToken: string,
): TripPlannerData => {
  const destinationIds = new Set(
    plannerData.destinations.map((destination) => destination.id),
  );
  const transportOptionIds = new Set(
    plannerData.transportOptions.map((transportOption) => transportOption.id),
  );
  const missingDestinations = activityFallbackDestinations
    .filter((destination) => !destinationIds.has(destination.id))
    .map((destination) => ({ ...destination, isStaticFallback: true }));
  const missingDestinationIds = new Set(
    missingDestinations.map((destination) => destination.id),
  );
  const missingTransportOptions = activityFallbackTransportOptions.filter(
    (transportOption) => !transportOptionIds.has(transportOption.id),
  );
  const destinationsWithFallbackCosts = plannerData.destinations.map(
    (destination) => {
      const costEstimate = costEstimateFallbacks[destination.id];

      if (
        destination.content.costEstimate !== undefined ||
        costEstimate === undefined
      ) {
        return destination;
      }

      return {
        ...destination,
        content: {
          ...destination.content,
          costEstimate,
        },
      };
    },
  );

  return {
    ...plannerData,
    destinations: [...destinationsWithFallbackCosts, ...missingDestinations],
    transportOptions: [
      ...plannerData.transportOptions,
      ...missingTransportOptions,
    ],
    preferences: [
      ...plannerData.preferences,
      ...getStaticFallbackTripPreferences(viewerToken, missingDestinationIds),
    ],
  };
};

export const fetchTripPlannerData = async (
  viewerToken: string,
): Promise<TripPlannerData> => {
  const client = requireSupabase();

  const [
    destinationsResponse,
    dateOptionsResponse,
    transportOptionsResponse,
    preferencesResponse,
    commentsResponse,
  ] = await Promise.all([
    client
      .from("travel_destinations")
      .select(
        "id, slug, name, region, destination_type, latitude, longitude, marker_label, summary, recommended_months, recommended_duration, main_image_url, image_source_url, image_credit, tags, content",
      )
      .order("destination_type", { ascending: true })
      .order("name", { ascending: true }),
    client
      .from("travel_date_options")
      .select(
        "id, label, start_date, end_date, nights, includes_weekend, sort_order",
      )
      .order("sort_order", { ascending: true }),
    client
      .from("travel_transport_options")
      .select(
        "id, destination_id, mode, label, route_steps, estimated_time, estimated_cost, requires_car, station_rental_recommended, risk_note, sort_order",
      )
      .order("sort_order", { ascending: true }),
    client.rpc("list_trip_preferences_for_viewer", {
      p_viewer_token: viewerToken,
    }),
    client.rpc("list_destination_comments_for_viewer", {
      p_viewer_token: viewerToken,
    }),
  ]);

  const firstError =
    destinationsResponse.error ??
    dateOptionsResponse.error ??
    transportOptionsResponse.error ??
    preferencesResponse.error ??
    commentsResponse.error;

  if (firstError !== null) {
    throw new Error(firstError.message);
  }

  return mergeActivityFallback(
    {
      destinations: (destinationsResponse.data ?? []) as TravelDestination[],
      dateOptions: (dateOptionsResponse.data ?? []) as TravelDateOption[],
      transportOptions: (transportOptionsResponse.data ??
        []) as TravelTransportOption[],
      preferences: (preferencesResponse.data ?? []) as TripPreference[],
      comments: (commentsResponse.data ?? []) as DestinationComment[],
    },
    viewerToken,
  );
};

type SubmitTripPreferenceArgs = {
  destinationId: string;
  startDate: string;
  endDate: string;
  transportOptionId: string;
  voterName: string;
  voterToken: string;
};

export const submitTripPreference = async ({
  destinationId,
  startDate,
  endDate,
  transportOptionId,
  voterName,
  voterToken,
}: SubmitTripPreferenceArgs): Promise<TripPreference> => {
  const client = requireSupabase();
  const { data, error } = await client.rpc("submit_trip_preference_dates", {
    p_destination_id: destinationId,
    p_start_date: startDate,
    p_end_date: endDate,
    p_transport_option_id: transportOptionId,
    p_voter_name: voterName,
    p_voter_token: voterToken,
  });

  if (error !== null) {
    throw new Error(error.message);
  }

  return (data as TripPreference[])[0];
};

export const submitStaticFallbackTripPreference = ({
  destinationId,
  startDate,
  endDate,
  transportOptionId,
  voterName,
  voterToken,
}: SubmitTripPreferenceArgs): TripPreference => {
  const now = new Date().toISOString();
  const currentPreferences = readStaticFallbackPreferences();
  const existingPreference = currentPreferences.find(
    (preference) =>
      preference.destination_id === destinationId &&
      preference.voter_token === voterToken,
  );
  const nextPreference: StaticFallbackPreference = {
    id: existingPreference?.id ?? `fallback-${window.crypto.randomUUID()}`,
    destination_id: destinationId,
    start_date: startDate,
    end_date: endDate,
    transport_option_id: transportOptionId,
    voter_name: voterName,
    voter_token: voterToken,
    liker_tokens: existingPreference?.liker_tokens ?? [],
    created_at: existingPreference?.created_at ?? now,
    updated_at: now,
  };

  writeStaticFallbackPreferences([
    ...currentPreferences.filter(
      (preference) => preference.id !== nextPreference.id,
    ),
    nextPreference,
  ]);

  return toTripPreference(nextPreference, voterToken);
};

export const deleteTripPreference = async (
  preferenceId: string,
  voterToken: string,
): Promise<boolean> => {
  const client = requireSupabase();
  const { data, error } = await client.rpc("delete_trip_preference", {
    p_preference_id: preferenceId,
    p_voter_token: voterToken,
  });

  if (error !== null) {
    throw new Error(error.message);
  }

  return Boolean(data);
};

export const deleteStaticFallbackTripPreference = (
  preferenceId: string,
  voterToken: string,
): boolean => {
  const currentPreferences = readStaticFallbackPreferences();
  const nextPreferences = currentPreferences.filter(
    (preference) =>
      preference.id !== preferenceId || preference.voter_token !== voterToken,
  );

  writeStaticFallbackPreferences(nextPreferences);

  return nextPreferences.length !== currentPreferences.length;
};

export const toggleTripPreferenceLike = async (
  preferenceId: string,
  likerToken: string,
): Promise<boolean> => {
  const client = requireSupabase();
  const { data, error } = await client.rpc("toggle_trip_preference_like", {
    p_preference_id: preferenceId,
    p_liker_token: likerToken,
  });

  if (error !== null) {
    throw new Error(error.message);
  }

  return Boolean(data);
};

export const toggleStaticFallbackTripPreferenceLike = (
  preferenceId: string,
  likerToken: string,
): boolean => {
  const currentPreferences = readStaticFallbackPreferences();
  let didToggle = false;
  const nextPreferences = currentPreferences.map((preference) => {
    if (preference.id !== preferenceId) {
      return preference;
    }

    didToggle = true;
    const likerTokens = preference.liker_tokens.includes(likerToken)
      ? preference.liker_tokens.filter((token) => token !== likerToken)
      : [...preference.liker_tokens, likerToken];

    return {
      ...preference,
      liker_tokens: likerTokens,
      updated_at: new Date().toISOString(),
    };
  });

  writeStaticFallbackPreferences(nextPreferences);

  return didToggle;
};

type SubmitDestinationCommentArgs = {
  destinationId: string;
  commenterName: string;
  commenterToken: string;
  body: string;
};

export const submitDestinationComment = async ({
  destinationId,
  commenterName,
  commenterToken,
  body,
}: SubmitDestinationCommentArgs): Promise<DestinationComment> => {
  const client = requireSupabase();
  const { data, error } = await client.rpc("submit_destination_comment", {
    p_destination_id: destinationId,
    p_commenter_name: commenterName,
    p_commenter_token: commenterToken,
    p_body: body,
  });

  if (error !== null) {
    throw new Error(error.message);
  }

  return (data as DestinationComment[])[0];
};

export const deleteDestinationComment = async (
  commentId: string,
  commenterToken: string,
): Promise<boolean> => {
  const client = requireSupabase();
  const { data, error } = await client.rpc("delete_destination_comment", {
    p_comment_id: commentId,
    p_commenter_token: commenterToken,
  });

  if (error !== null) {
    throw new Error(error.message);
  }

  return Boolean(data);
};

type SubmitScheduleCommentArgs = {
  commenterName: string;
  commenterToken: string;
  body: string;
};

export const submitScheduleComment = async ({
  commenterName,
  commenterToken,
  body,
}: SubmitScheduleCommentArgs): Promise<DestinationComment> => {
  return submitDestinationComment({
    destinationId: scheduleCommentDestinationId,
    commenterName,
    commenterToken,
    body: `${scheduleCommentMarker}${body}`,
  });
};

export const deleteScheduleComment = deleteDestinationComment;
