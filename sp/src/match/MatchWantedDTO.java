package match;

// 매칭에서 구하는 팀원에 대한 내용 
public class MatchWantedDTO {

	// 매칭 멤버 테이블 인덱스
	private Integer matchMemberIx;

	// 매칭 글 인덱스
	private Integer matchIx;

	// 담당 역할-대분류
	private String mainRole;

	// 담당 역할-소분류
	private String detailRole;

	// 필요 능력사항
	private String requiredAbility;

	// 필요 인원 수
	private String wantedNumber;

	// 모집된 인원 수
	private String recruitedNumber;

	// 기본 생성자
	public MatchWantedDTO() {
		System.out.println("MatchWantedDTO 생성");
	}
	
	// 모든 필드 생성자
	public MatchWantedDTO(Integer matchMemberIx, Integer matchIx, String mainRole, String detailRole,
			String requiredAbility, String wantedNumber, String recruitedNumber) {
		super();
		this.matchMemberIx = matchMemberIx;
		this.matchIx = matchIx;
		this.mainRole = mainRole;
		this.detailRole = detailRole;
		this.requiredAbility = requiredAbility;
		this.wantedNumber = wantedNumber;
		this.recruitedNumber = recruitedNumber;
	}
	
	public Integer getMatchMemberIx() {
		return matchMemberIx;
	}

	public void setMatchMemberIx(Integer matchMemberIx) {
		this.matchMemberIx = matchMemberIx;
	}

	public Integer getMatchIx() {
		return matchIx;
	}

	public void setMatchIx(Integer matchIx) {
		this.matchIx = matchIx;
	}

	public String getMainRole() {
		return mainRole;
	}

	public void setMainRole(String mainRole) {
		this.mainRole = mainRole;
	}

	public String getDetailRole() {
		return detailRole;
	}

	public void setDetailRole(String detailRole) {
		this.detailRole = detailRole;
	}

	public String getRequiredAbility() {
		return requiredAbility;
	}

	public void setRequiredAbility(String requiredAbility) {
		this.requiredAbility = requiredAbility;
	}

	public String getWantedNumber() {
		return wantedNumber;
	}

	public void setWantedNumber(String wantedNumber) {
		this.wantedNumber = wantedNumber;
	}

	public String getRecruitedNumber() {
		return recruitedNumber;
	}

	public void setRecruitedNumber(String recruitedNumber) {
		this.recruitedNumber = recruitedNumber;
	}
}
