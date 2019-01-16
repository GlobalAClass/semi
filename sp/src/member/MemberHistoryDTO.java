package member;

// 회원의 공모전 이력
public class MemberHistoryDTO {

	// 공모전이력 인덱스
	private Integer memberHistroyIx;

	// 회원 인덱스
	private Integer memberIx;

	// 공모전 이름
	private String cName;

	// 공모전기간
	private String period;

	// 담당 역할-대분류
	private String mainRole;

	// 담당 역할-소분류
	private String detailRole;

	// 수상내역
	private String award;

	// 상세내용
	private String detail;

	//기본 생성자
	public MemberHistoryDTO() {
		System.out.println("MemberHistoryDTO 생성");
	}
	
	//모든 필드를 가지는 생성자
	public MemberHistoryDTO(Integer memberHistroyIx, Integer memberIx, String cName, String period, String mainRole,
			String detailRole, String award, String detail) {
		super();
		this.memberHistroyIx = memberHistroyIx;
		this.memberIx = memberIx;
		this.cName = cName;
		this.period = period;
		this.mainRole = mainRole;
		this.detailRole = detailRole;
		this.award = award;
		this.detail = detail;
	}
	//입려 받는 필드만 갖는 생성자.
	public MemberHistoryDTO(String cName, String period, String mainRole, String detailRole, String award,
			String detail) {
		super();
		this.cName = cName;
		this.period = period;
		this.mainRole = mainRole;
		this.detailRole = detailRole;
		this.award = award;
		this.detail = detail;
	}

	public Integer getMemberHistroyIx() {
		return memberHistroyIx;
	}

	public void setMemberHistroyIx(Integer memberHistroyIx) {
		this.memberHistroyIx = memberHistroyIx;
	}

	public Integer getMemberIx() {
		return memberIx;
	}

	public void setMemberIx(Integer memberIx) {
		this.memberIx = memberIx;
	}

	public String getCName() {
		return cName;
	}

	public void setCName(String cName) {
		this.cName = cName;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
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

	public String getAward() {
		return award;
	}

	public void setAward(String award) {
		this.award = award;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

}
