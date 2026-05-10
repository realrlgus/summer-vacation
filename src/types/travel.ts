export type TravelDestinationType = "major" | "minor" | "alternative";

export type TravelAttraction = {
  name: string;
  kind: string;
  description: string;
  sourceUrl: string;
  mapUrl: string;
  imageUrl?: string;
  imageSourceUrl?: string;
  naverUrl?: string;
  googleUrl?: string;
  kakaoUrl?: string;
  reviewSourceUrls?: string[];
};

export type TravelStay = {
  name: string;
  area: string;
  notes: string;
  airbnbUrl?: string;
  sourceUrls?: string[];
};

export type TravelActivity = {
  name: string;
  risk: string;
  imageUrl?: string;
  imageSourceUrl?: string;
};

export type TravelDestinationContent = {
  fit?: string;
  sourceUrls?: string[];
  blogEvidenceUrls?: string[];
  reviewThemes?: string[];
  attractions?: TravelAttraction[];
  stays?: TravelStay[];
  activities?: TravelActivity[];
};

export type TravelDestination = {
  id: string;
  slug: string;
  name: string;
  region: string;
  destination_type: TravelDestinationType;
  latitude: number;
  longitude: number;
  marker_label: string;
  summary: string;
  recommended_months: string;
  recommended_duration: string;
  main_image_url: string | null;
  image_source_url: string | null;
  image_credit: string | null;
  tags: string[];
  content: TravelDestinationContent;
};

export type TravelDateOption = {
  id: string;
  label: string;
  start_date: string;
  end_date: string;
  nights: number;
  includes_weekend: boolean;
  sort_order: number;
};

export type TravelTransportMode = "ktx_local" | "car_only" | "ktx_rental";

export type TravelTransportOption = {
  id: string;
  destination_id: string;
  mode: TravelTransportMode;
  label: string;
  route_steps: string[];
  estimated_time: string;
  estimated_cost: string;
  requires_car: boolean;
  station_rental_recommended: boolean;
  risk_note: string;
  sort_order: number;
};

export type TripPreference = {
  id: string;
  destination_id: string;
  date_option_id: string | null;
  start_date: string | null;
  end_date: string | null;
  transport_option_id: string;
  voter_name: string;
  like_count: number;
  created_at: string;
  updated_at: string;
};

export type DestinationComment = {
  id: string;
  destination_id: string;
  commenter_name: string;
  body: string;
  created_at: string;
};

export type TripPlannerData = {
  destinations: TravelDestination[];
  dateOptions: TravelDateOption[];
  transportOptions: TravelTransportOption[];
  preferences: TripPreference[];
  comments: DestinationComment[];
};

export type PreferenceFormState = {
  startDate: string;
  endDate: string;
  transportOptionId: string;
};
