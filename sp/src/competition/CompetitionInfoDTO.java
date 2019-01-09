package competition;

//공모전 정보
public class CompetitionInfoDTO {

	// 공모전 정보 인덱스
	private Integer competitionInfoIx;

	// 공모전 제목
	private String cName;

	// 분야
	private String field;

	// 팀/개인
	private String teamSolo;

	// 주최
	private String auspice;

	// 주관
	private String manage;

	// 참가자격
	private String entitlement;

	// 접수기간
	private String period;

	// 홈페이지링크
	private String link;

	// 공모전 상세 내역
	private String detail;
	
	// 기본 생성자
	public CompetitionInfoDTO() {
		System.out.println("CompetitionInfoDTO 생성");
	}
	
	// 모든 필드 가지는 생성자
	public CompetitionInfoDTO(Integer competitionInfoIx, String cName, String field, String teamSolo, String auspice,
			String manage, String entitlement, String period, String link, String detail) {
		super();
		this.competitionInfoIx = competitionInfoIx;
		this.cName = cName;
		this.field = field;
		this.teamSolo = teamSolo;
		this.auspice = auspice;
		this.manage = manage;
		this.entitlement = entitlement;
		this.period = period;
		this.link = link;
		this.detail = detail;
	}

	public Integer getCompetitionInfoIx() {
		return competitionInfoIx;
	}

	public void setCompetitionInfoIx(Integer competitionInfoIx) {
		this.competitionInfoIx = competitionInfoIx;
	}

	public String getCName() {
		return cName;
	}

	public void setCName(String cName) {
		this.cName = cName;
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

	public String getManage() {
		return manage;
	}

	public void setManage(String manage) {
		this.manage = manage;
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

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

}
