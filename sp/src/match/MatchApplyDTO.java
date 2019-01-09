package match;

// 모임 신청 글(지원자가 쓴 글) 
public class MatchApplyDTO {

	// 지원 글 인덱스
	private Integer matchApplyIx;

	// 신청 회원 인덱스
	private Integer memberIx;

	// 매칭 글 인덱스
	private Integer matchIx;

	// 담당 역할-대분류
	private String mainRole;

	// 담당 역할-소분류
	private String detailRole;

	// 자기소개(추가 가능한역할,포부 etc)
	private String aboutApplicant;

	// 다른 공모전or플젝 참여여부
	private String otherExC;

	// 기본 생성자
	public MatchApplyDTO() {
		System.out.println("MatchApplyDTO 생성");
	}
	
	// 모든 필드 생성자
	public MatchApplyDTO(Integer matchApplyIx, Integer memberIx, Integer matchIx, String mainRole, String detailRole,
			String aboutApplicant, String otherExC) {
		super();
		this.matchApplyIx = matchApplyIx;
		this.memberIx = memberIx;
		this.matchIx = matchIx;
		this.mainRole = mainRole;
		this.detailRole = detailRole;
		this.aboutApplicant = aboutApplicant;
		this.otherExC = otherExC;
	}
	
	public Integer getMatchApplyIx() {
		return matchApplyIx;
	}

	public void setMatchApplyIx(Integer matchApplyIx) {
		this.matchApplyIx = matchApplyIx;
	}

	public Integer getMemberIx() {
		return memberIx;
	}

	public void setMemberIx(Integer memberIx) {
		this.memberIx = memberIx;
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

	public String getAboutApplicant() {
		return aboutApplicant;
	}

	public void setAboutApplicant(String aboutApplicant) {
		this.aboutApplicant = aboutApplicant;
	}

	public String getOtherExC() {
		return otherExC;
	}

	public void setOtherExC(String otherExC) {
		this.otherExC = otherExC;
	}

}
