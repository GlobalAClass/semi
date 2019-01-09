package match;

// 지원서를 보고 모집한 인원(모임장이 뽑은 인원) 
public class MatchRecruitedDTO {

	// 모집한 인원 인덱스
	private Integer matchRecruitedix;

	// 매칭 글 인덱스
	private Integer matchIx;

	// 신청 글 인덱스
	private Integer matchApplyIx;

	// 기본 생성자
	public MatchRecruitedDTO() {
		System.out.println("MatchRecruitedDTO 생성");
	}
	
	// 모든 필드 생성자
	public MatchRecruitedDTO(Integer matchRecruitedix, Integer matchIx, Integer matchApplyIx) {
		super();
		this.matchRecruitedix = matchRecruitedix;
		this.matchIx = matchIx;
		this.matchApplyIx = matchApplyIx;
	}
	
	public Integer getMatchRecruitedix() {
	        return matchRecruitedix;
	    }

	public void setMatchRecruitedix(Integer matchRecruitedix) {
	        this.matchRecruitedix = matchRecruitedix;
	    }

	public Integer getMatchIx() {
		return matchIx;
	}

	public void setMatchIx(Integer matchIx) {
		this.matchIx = matchIx;
	}

	public Integer getMatchApplyIx() {
		return matchApplyIx;
	}

	public void setMatchApplyIx(Integer matchApplyIx) {
		this.matchApplyIx = matchApplyIx;
	}

}
