import { supabase } from "./supabase";
import type { TravelCandidate, TravelVote } from "../types/travel";

export const fetchTravelCandidates = async (): Promise<TravelCandidate[]> => {
  if (supabase === null) {
    throw new Error("Supabase 환경 변수가 설정되지 않았습니다.");
  }

  const { data, error } = await supabase
    .from("travel_candidates")
    .select("id, category, title, region, description, image_url, tags, data")
    .order("category", { ascending: true })
    .order("title", { ascending: true });

  if (error !== null) {
    throw new Error(error.message);
  }

  return (data ?? []) as TravelCandidate[];
};

export const fetchTravelVotes = async (): Promise<TravelVote[]> => {
  if (supabase === null) {
    throw new Error("Supabase 환경 변수가 설정되지 않았습니다.");
  }

  const { data, error } = await supabase.rpc("list_travel_votes");

  if (error !== null) {
    throw new Error(error.message);
  }

  return (data ?? []) as TravelVote[];
};

type UpsertTravelVoteArgs = {
  candidateId: string;
  voterName: string;
  voterToken: string;
  score: number;
  comment: string;
};

export const upsertTravelVote = async ({
  candidateId,
  voterName,
  voterToken,
  score,
  comment,
}: UpsertTravelVoteArgs): Promise<TravelVote> => {
  if (supabase === null) {
    throw new Error("Supabase 환경 변수가 설정되지 않았습니다.");
  }

  const { data, error } = await supabase.rpc("submit_travel_vote", {
    p_candidate_id: candidateId,
    p_voter_name: voterName,
    p_voter_token: voterToken,
    p_score: score,
    p_comment: comment.length > 0 ? comment : null,
  });

  if (error !== null) {
    throw new Error(error.message);
  }

  return (data as TravelVote[])[0];
};
