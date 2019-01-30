package match;

// 모임 신청 글(지원자가 쓴 글) 
public class MatchApplyDTO {

	// 지원 글 인덱스
	private Integer matchApplyIx;

	// 신청 회원 인덱스
	private Integer memberIx;

	// 매칭 글 인덱스
	private Integer matchIx;

	// 매칭 멤버 테이블 인덱스
	private Integer matchWantedIx;

	// 자기소개(추가 가능한역할,포부 etc)
	private String aboutApplicant;

	// 다른 공모전or플젝 참여여부
	private String otherExC;
	
	//모집 여부
	private String hold;

	// 기본 생성자
	public MatchApplyDTO() {
		System.out.println("MatchApplyDTO 생성");
	}
	
	// 모든 필드 생성자
	public MatchApplyDTO(Integer matchApplyIx, Integer memberIx, Integer matchIx, Integer matchWantedIx,
			String aboutApplicant, String otherExC, String hold) {
		super();
		this.matchApplyIx = matchApplyIx;
		this.memberIx = memberIx;
		this.matchIx = matchIx;
		this.matchWantedIx = matchWantedIx;
		this.aboutApplicant = aboutApplicant;
		this.otherExC = otherExC;
		this.hold = hold;
	}
	
	//MatciApplyIx를 제외한 생성자
	public MatchApplyDTO(Integer memberIx, Integer matchIx, Integer matchWantedIx, String aboutApplicant,
			String otherExC, String hold) {
		super();
		this.memberIx = memberIx;
		this.matchIx = matchIx;
		this.matchWantedIx = matchWantedIx;
		this.aboutApplicant = aboutApplicant;
		this.otherExC = otherExC;
		this.hold = hold;
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

	public Integer getMatchWantedIx() {
		return matchWantedIx;
	}

	public void setMatchWantedIx(Integer matchWantedIx) {
		this.matchWantedIx = matchWantedIx;
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

	public String getHold() {
		return hold;
	}

	public void setHold(String hold) {
		this.hold = hold;
	}
}
