export type TravelCandidateCategory =
  | "destination"
  | "restaurant"
  | "attraction"
  | "stay";

export type TravelCandidateData = {
  budgetLevel?: string;
  travelTime?: string;
  priceLevel?: string;
  capacityFit?: string;
  reviewThemes?: string[];
  needsVerification?: string[];
};

export type TravelCandidate = {
  id: string;
  category: TravelCandidateCategory;
  title: string;
  region: string | null;
  description: string;
  image_url: string | null;
  tags: string[];
  data: TravelCandidateData;
};

export type TravelVote = {
  id: string;
  candidate_id: string;
  voter_name: string;
  score: number;
  comment: string | null;
  created_at: string;
  updated_at: string;
};

export type CandidateVoteSummary = {
  averageScore: number;
  voteCount: number;
};

export type VoteFormState = {
  score: number;
  comment: string;
};
