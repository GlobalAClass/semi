package competition;

//공모전 정보
public class CompetitionInfoDTO {

	// 공모전 정보 인덱스
	private Integer competitionInfoIx;

	// 공모전 제목
	private String CName;

	// 분야
	private String field;

	// 팀/개인
	private String teamSolo;

	// 주최
	private String auspice;

	// 주관
	private String CManage;

	// 참가자격
	private String entitlement;

	// 접수기간
	private String period;

	// 홈페이지링크
	private String CLink;

	// 공모전 상세 내역
	private String detail;
	
	// 기본 생성자
	public CompetitionInfoDTO() {
		System.out.println("CompetitionInfoDTO 생성");
	}
	
	// 모든 필드 가지는 생성자
	public CompetitionInfoDTO(Integer competitionInfoIx, String CName, String field, String teamSolo, String auspice,
			String CManage, String entitlement, String period, String CLink, String detail) {
		super();
		this.competitionInfoIx = competitionInfoIx;
		this.CName = CName;
		this.field = field;
		this.teamSolo = teamSolo;
		this.auspice = auspice;
		this.CManage = CManage;
		this.entitlement = entitlement;
		this.period = period;
		this.CLink = CLink;
		this.detail = detail;
	}

	public Integer getCompetitionInfoIx() {
		return competitionInfoIx;
	}

	public void setCompetitionInfoIx(Integer competitionInfoIx) {
		this.competitionInfoIx = competitionInfoIx;
	}

	public String getCName() {
		return CName;
	}

	public void setCName(String CName) {
		this.CName = CName;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getTeamSolo() {
		return teamSolo;
	}

	public void setTeamSolo(String teamSolo) {
		this.teamSolo = teamSolo;
	}

	public String getAuspice() {
		return auspice;
	}

	public void setAuspice(String auspice) {
		this.auspice = auspice;
	}

	public String getCManage() {
		return CManage;
	}

	public void setCManage(String CManage) {
		this.CManage = CManage;
	}

	public String getEntitlement() {
		return entitlement;
	}

	public void setEntitlement(String entitlement) {
		this.entitlement = entitlement;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}

	public String getCLink() {
		return CLink;
	}

	public void setCLink(String CLink) {
		this.CLink = CLink;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

}
