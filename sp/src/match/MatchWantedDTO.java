package match;

// 매칭에서 구하는 팀원에 대한 내용 
public class MatchWantedDTO {

	// 매칭 멤버 테이블 인덱스
	private Integer matchWantedIx;

	// 매칭 글 인덱스
	private Integer matchIx;

	// 담당 역할-대분류
	private String wMainRole;

	// 담당 역할-소분류
	private String wDetailRole;

	// 필요 능력사항
	private String requiredAbility;

	// 필요 인원 수
	private String wantedNumber;

	// 해당 역할 모집된 인원 수
	private String recruitedNumber;

	// 기본 생성자
	public MatchWantedDTO() {
		System.out.println("MatchWantedDTO 생성");
	}
	
	// 모든 필드 생성자
	public MatchWantedDTO(Integer matchWantedIx, Integer matchIx, String wMainRole, String wDetailRole,
			String requiredAbility, String wantedNumber, String recruitedNumber) {
		super();
		this.matchWantedIx = matchWantedIx;
		this.matchIx = matchIx;
		this.wMainRole = wMainRole;
		this.wDetailRole = wDetailRole;
		this.requiredAbility = requiredAbility;
		this.wantedNumber = wantedNumber;
		this.recruitedNumber = recruitedNumber;
	}
	
	//해당테이블 인덱스(matchWantedIx)를 제외한 생성자.
	public MatchWantedDTO(Integer matchIx, String wMainRole, String wDetailRole, String requiredAbility,
			String wantedNumber, String recruitedNumber) {
		super();
		this.matchIx = matchIx;
		this.wMainRole = wMainRole;
		this.wDetailRole = wDetailRole;
		this.requiredAbility = requiredAbility;
		this.wantedNumber = wantedNumber;
		this.recruitedNumber = recruitedNumber;
	}
	//역할과 필요요구사항 가지는 생성자
	public MatchWantedDTO(String wMainRole, String wDetailRole, String requiredAbility) {
		super();
		this.wMainRole = wMainRole;
		this.wDetailRole = wDetailRole;
		this.requiredAbility = requiredAbility;
	}

	
	public Integer getmatchWantedIx() {
		return matchWantedIx;
	}

	public void setmatchWantedIxx(Integer matchWantedIx) {
		this.matchWantedIx = matchWantedIx;
	}

	public Integer getMatchIx() {
		return matchIx;
	}

	public void setMatchIx(Integer matchIx) {
		this.matchIx = matchIx;
	}

	public String getwMainRole() {
		return wMainRole;
	}

	public void setwMainRole(String wMainRole) {
		this.wMainRole = wMainRole;
	}

	public String getwDetailRole() {
		return wDetailRole;
	}

	public void setwDetailRole(String wDetailRole) {
		this.wDetailRole = wDetailRole;
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
