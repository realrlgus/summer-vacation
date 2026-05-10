import { supabase } from "./supabase";
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

export const fetchTripPlannerData = async (): Promise<TripPlannerData> => {
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
    client.rpc("list_trip_preferences"),
    client.rpc("list_destination_comments"),
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

  return {
    destinations: (destinationsResponse.data ?? []) as TravelDestination[],
    dateOptions: (dateOptionsResponse.data ?? []) as TravelDateOption[],
    transportOptions: (transportOptionsResponse.data ??
      []) as TravelTransportOption[],
    preferences: (preferencesResponse.data ?? []) as TripPreference[],
    comments: (commentsResponse.data ?? []) as DestinationComment[],
  };
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
