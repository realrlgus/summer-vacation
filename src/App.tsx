import {
  CheckCircle2,
  MapPin,
  MessageCircle,
  RefreshCw,
  Send,
  Star,
  Users,
} from "lucide-react";
import { useEffect, useMemo, useState } from "react";
import {
  fetchTravelCandidates,
  fetchTravelVotes,
  upsertTravelVote,
} from "./lib/travelApi";
import { isSupabaseConfigured } from "./lib/supabase";
import type {
  CandidateVoteSummary,
  TravelCandidate,
  TravelCandidateCategory,
  TravelVote,
  VoteFormState,
} from "./types/travel";

const CategoryLabel: Record<TravelCandidateCategory, string> = {
  destination: "여행지",
  restaurant: "맛집",
  attraction: "볼거리",
  stay: "숙소",
};

const defaultVoteFormState: VoteFormState = {
  score: 3,
  comment: "",
};

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

export const App = () => {
  const [candidates, setCandidates] = useState<TravelCandidate[]>([]);
  const [votes, setVotes] = useState<TravelVote[]>([]);
  const [voterName, setVoterName] = useState("");
  const [voteForms, setVoteForms] = useState<Record<string, VoteFormState>>({});
  const [isLoading, setIsLoading] = useState(true);
  const [isSubmittingCandidateId, setIsSubmittingCandidateId] = useState<
    string | null
  >(null);
  const [errorMessage, setErrorMessage] = useState<string | null>(null);
  const [successMessage, setSuccessMessage] = useState<string | null>(null);
  const [voterToken, setVoterToken] = useState("");

  const voteSummaryByCandidateId = useMemo(() => {
    return votes.reduce<Record<string, CandidateVoteSummary>>((summary, vote) => {
      const current = summary[vote.candidate_id] ?? {
        averageScore: 0,
        voteCount: 0,
      };
      const totalScore = current.averageScore * current.voteCount + vote.score;
      const voteCount = current.voteCount + 1;

      summary[vote.candidate_id] = {
        averageScore: totalScore / voteCount,
        voteCount,
      };

      return summary;
    }, {});
  }, [votes]);

  const sortedCandidates = useMemo(() => {
    return [...candidates].sort((firstCandidate, secondCandidate) => {
      const firstSummary = voteSummaryByCandidateId[firstCandidate.id];
      const secondSummary = voteSummaryByCandidateId[secondCandidate.id];

      return (
        (secondSummary?.averageScore ?? 0) - (firstSummary?.averageScore ?? 0)
      );
    });
  }, [candidates, voteSummaryByCandidateId]);

  const loadTravelData = async () => {
    if (!isSupabaseConfigured) {
      setErrorMessage("Supabase 환경 변수가 설정되지 않았습니다.");
      setIsLoading(false);
      return;
    }

    setIsLoading(true);
    setErrorMessage(null);

    try {
      const [nextCandidates, nextVotes] = await Promise.all([
        fetchTravelCandidates(),
        fetchTravelVotes(),
      ]);

      setCandidates(nextCandidates);
      setVotes(nextVotes);
      setVoteForms(
        nextCandidates.reduce<Record<string, VoteFormState>>((forms, candidate) => {
          forms[candidate.id] = defaultVoteFormState;
          return forms;
        }, {}),
      );
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
    void loadTravelData();
  }, []);

  const handleScoreChange = (candidateId: string, score: number) => {
    setVoteForms((currentForms) => ({
      ...currentForms,
      [candidateId]: {
        ...defaultVoteFormState,
        ...currentForms[candidateId],
        score,
      },
    }));
  };

  const handleCommentChange = (candidateId: string, comment: string) => {
    setVoteForms((currentForms) => ({
      ...currentForms,
      [candidateId]: {
        ...defaultVoteFormState,
        ...currentForms[candidateId],
        comment,
      },
    }));
  };

  const handleSubmitVote = async (candidateId: string) => {
    const trimmedVoterName = voterName.trim();
    const voteForm = voteForms[candidateId] ?? defaultVoteFormState;

    if (trimmedVoterName.length === 0) {
      setErrorMessage("투표하려면 이름을 먼저 입력하세요.");
      return;
    }

    const currentVoterToken =
      voterToken.length > 0 ? voterToken : getVoterToken();

    if (voterToken.length === 0) {
      setVoterToken(currentVoterToken);
    }

    setIsSubmittingCandidateId(candidateId);
    setErrorMessage(null);
    setSuccessMessage(null);

    try {
      await upsertTravelVote({
        candidateId,
        voterName: trimmedVoterName,
        voterToken: currentVoterToken,
        score: voteForm.score,
        comment: voteForm.comment.trim(),
      });

      setVotes(await fetchTravelVotes());
      setSuccessMessage("투표가 저장되었습니다.");
    } catch (error) {
      setErrorMessage(
        error instanceof Error ? error.message : "투표 저장에 실패했습니다.",
      );
    } finally {
      setIsSubmittingCandidateId(null);
    }
  };

  return (
    <main className="app-shell">
      <section className="top-bar" aria-labelledby="page-title">
        <div>
          <p className="eyebrow">Summer Vacation</p>
          <h1 id="page-title">여행 후보 투표</h1>
        </div>
        <button className="icon-button" type="button" onClick={loadTravelData}>
          <RefreshCw size={18} aria-hidden="true" />
          <span>새로고침</span>
        </button>
      </section>

      <section className="control-panel" aria-label="투표 참여 정보">
        <label className="name-field">
          <span>내 이름</span>
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

      {isLoading ? (
        <p className="empty-state">후보를 불러오는 중입니다.</p>
      ) : sortedCandidates.length === 0 ? (
        <p className="empty-state">아직 여행 후보가 없습니다.</p>
      ) : (
        <section className="candidate-grid" aria-label="여행 후보 목록">
          {sortedCandidates.map((candidate) => {
            const voteForm = voteForms[candidate.id] ?? defaultVoteFormState;
            const voteSummary = voteSummaryByCandidateId[candidate.id] ?? {
              averageScore: 0,
              voteCount: 0,
            };
            const isSubmitting = isSubmittingCandidateId === candidate.id;

            return (
              <article className="candidate-card" key={candidate.id}>
                {candidate.image_url !== null ? (
                  <img
                    className="candidate-image"
                    src={candidate.image_url}
                    alt=""
                    loading="lazy"
                  />
                ) : null}
                <div className="candidate-content">
                  <div className="candidate-heading">
                    <div>
                      <p className="category-label">
                        {CategoryLabel[candidate.category]}
                      </p>
                      <h2>{candidate.title}</h2>
                    </div>
                    <div className="score-badge" aria-label="평균 점수">
                      <Star size={16} aria-hidden="true" />
                      {voteSummary.voteCount > 0
                        ? voteSummary.averageScore.toFixed(1)
                        : "-"}
                    </div>
                  </div>

                  <p className="candidate-region">
                    <MapPin size={16} aria-hidden="true" />
                    {candidate.region ?? "지역 미정"}
                  </p>
                  <p className="candidate-description">{candidate.description}</p>

                  <div className="tag-row" aria-label="태그">
                    {candidate.tags.map((tag) => (
                      <span key={tag}>{tag}</span>
                    ))}
                  </div>

                  <div className="review-themes">
                    {(candidate.data.reviewThemes ?? []).map((theme) => (
                      <p key={theme}>{theme}</p>
                    ))}
                  </div>

                  <div className="vote-summary">
                    <span>
                      <Users size={16} aria-hidden="true" />
                      {voteSummary.voteCount}명 투표
                    </span>
                    <span>
                      <MessageCircle size={16} aria-hidden="true" />
                      {
                        votes.filter(
                          (vote) =>
                            vote.candidate_id === candidate.id &&
                            vote.comment !== null,
                        ).length
                      }
                      개 코멘트
                    </span>
                  </div>

                  <div className="vote-form">
                    <label>
                      <span>점수</span>
                      <input
                        type="range"
                        min="1"
                        max="5"
                        step="1"
                        value={voteForm.score}
                        onChange={(event) =>
                          handleScoreChange(candidate.id, Number(event.target.value))
                        }
                      />
                      <strong>{voteForm.score}점</strong>
                    </label>
                    <textarea
                      value={voteForm.comment}
                      onChange={(event) =>
                        handleCommentChange(candidate.id, event.target.value)
                      }
                      maxLength={500}
                      placeholder="한 줄 의견"
                    />
                    <button
                      className="primary-button"
                      type="button"
                      disabled={isSubmitting}
                      onClick={() => void handleSubmitVote(candidate.id)}
                    >
                      <Send size={16} aria-hidden="true" />
                      <span>{isSubmitting ? "저장 중" : "투표 저장"}</span>
                    </button>
                  </div>
                </div>
              </article>
            );
          })}
        </section>
      )}
    </main>
  );
};
