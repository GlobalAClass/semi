package competition;

// 공모전 스크랩 
public class CompetitionScrapDTO {

	// 공모전 스크랩 인덱스
	private Integer competitionScrapIx;

	// 스크랩한 회원 인덱스
	private Integer memberIx;

	// 공모전 정보 인덱스
	private Integer competitionInfoIx;
	
	// 기본 생성자
	public CompetitionScrapDTO() {
		System.out.println("CompetitionScrapDTO 생성");
	}
	
	// 모든 필드 가지는 생성자
	public CompetitionScrapDTO(Integer competitionScrapIx, Integer memberIx, Integer competitionInfoIx) {
		super();
		this.competitionScrapIx = competitionScrapIx;
		this.memberIx = memberIx;
		this.competitionInfoIx = competitionInfoIx;
	}
	
	public Integer getCompetitionScrapIx() {
		return competitionScrapIx;
	}

	public void setCompetitionScrapIx(Integer competitionScrapIx) {
		this.competitionScrapIx = competitionScrapIx;
	}

	public Integer getMemberIx() {
		return memberIx;
	}

	public void setMemberIx(Integer memberIx) {
		this.memberIx = memberIx;
	}

	public Integer getCompetitionInfoIx() {
		return competitionInfoIx;
	}

	public void setCompetitionInfoIx(Integer competitionInfoIx) {
		this.competitionInfoIx = competitionInfoIx;
	}

}
