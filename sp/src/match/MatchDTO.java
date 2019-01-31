package match;

import java.sql.*;

// 모임 매칭 글(모임장이 쓴 글) 
public class MatchDTO {

	// 매칭 글 인덱스
	private Integer matchIx;

	// 글 쓴 회원 인덱스
	private Integer memberIx;
	
	// 공모전 정보 인덱스
	private Integer competitionInfoIx;
	
	// 모임명
	private String matchName;
	
	// 담당 역할-대분류
	private String mainRole;
	
	// 담당 역할-소분휴
	private String detailRole;
	
	// 현재 존재하는 팀원 수
	private String originalMemberNumber;

	// 시/도
	private String sido;

	// 시/군/구
	private String sigungu;

	// 한 주에 몇 회의 모임
	private String timesAWeek;

	// 요일
	private String day;

	// 구하고 싶은 팀원 수
	private String totalWantedNumber;

	// 나이제한
	private String ageRestriction;
	
	// 장비/기술 사항
	private String equipTech;
	
	// 구체적인 사항
	private String detail;

	// 완료 여부
	private String completedState;

	// 공모전 글 쓴 날짜
	private String writeDate;

	// 기본 생성자
	public MatchDTO() {
		System.out.println("MatchDTO 생성");
	}
	
	// 모든 필드 생성자
	public MatchDTO(Integer matchIx, Integer memberIx, Integer competitionInfoIx, String matchName, String mainRole,
			String detailRole, String originalMemberNumber, String sido, String sigungu, String timesAWeek, String day,
			String totalWantedNumber, String ageRestriction, String equipTech, String detail, String completedState,
			String writeDate) {
		super();
		this.matchIx = matchIx;
		this.memberIx = memberIx;
		this.competitionInfoIx = competitionInfoIx;
		this.matchName = matchName;
		this.mainRole = mainRole;
		this.detailRole = detailRole;
		this.originalMemberNumber = originalMemberNumber;
		this.sido = sido;
		this.sigungu = sigungu;
		this.timesAWeek = timesAWeek;
		this.day = day;
		this.totalWantedNumber = totalWantedNumber;
		this.ageRestriction = ageRestriction;
		this.equipTech = equipTech;
		this.detail = detail;
		this.completedState = completedState;
		this.writeDate = writeDate;
	}

	//index 매칭글인덱스 / 모임명
	public MatchDTO(Integer matchIx, Integer competitionInfoIx, String matchName) {
		super();
		this.matchIx = matchIx;
		this.competitionInfoIx = competitionInfoIx;
		this.matchName = matchName;
	}
	
	//index 제외한 생성자
	public MatchDTO(String matchName, String mainRole, String detailRole, String originalMemberNumber, String sido,
			String sigungu, String timesAWeek, String day, String totalWantedNumber, String ageRestriction,
			String equipTech, String detail, String completedState, String writeDate) {
		super();
		this.matchName = matchName;
		this.mainRole = mainRole;
		this.detailRole = detailRole;
		this.originalMemberNumber = originalMemberNumber;
		this.sido = sido;
		this.sigungu = sigungu;
		this.timesAWeek = timesAWeek;
		this.day = day;
		this.totalWantedNumber = totalWantedNumber;
		this.ageRestriction = ageRestriction;
		this.equipTech = equipTech;
		this.detail = detail;
		this.completedState = completedState;
		this.writeDate = writeDate;
	}

	//idx와 모임 진행중인지 여부, 모임명 가지는 생성자
	public MatchDTO(Integer matchIx, String matchName, String completedState) {
		super();
		this.matchIx = matchIx;
		this.matchName = matchName;
		this.completedState = completedState;
	}
	
	//idx와 모임명, 모임장의 역할, 모임 진행 여부 가지는 생성자
	public MatchDTO(Integer matchIx, String matchName, String mainRole, String detailRole, String completedState) {
		super();
		this.matchIx = matchIx;
		this.matchName = matchName;
		this.mainRole = mainRole;
		this.detailRole = detailRole;
		this.completedState = completedState;
	}
	

	public Integer getMatchIx() {
		return matchIx;
	}

	public void setMatchIx(Integer matchIx) {
		this.matchIx = matchIx;
	}

	public Integer getMemberIx() {
		return memberIx;
	}

	public void setMemberIx(Integer memberIx) {
		this.memberIx = memberIx;
	}

	public String getMatchName() {
		return matchName;
	}

	public void setMatchName(String matchName) {
		this.matchName = matchName;
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

	public String getOriginalMemberNumber() {
		return originalMemberNumber;
	}

	public void setOriginalMemberNumber(String originalMemberNumber) {
		this.originalMemberNumber = originalMemberNumber;
	}

	public String getSido() {
		return sido;
	}

	public void setSido(String sido) {
		this.sido = sido;
	}

	public String getSigungu() {
		return sigungu;
	}

	public void setSigungu(String sigungu) {
		this.sigungu = sigungu;
	}

	public String getTimesAWeek() {
		return timesAWeek;
	}

	public void setTimesAWeek(String timesAWeek) {
		this.timesAWeek = timesAWeek;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getTotalWantedNumber() {
		return totalWantedNumber;
	}

	public void setTotalWantedNumber(String totalWantedNumber) {
		this.totalWantedNumber = totalWantedNumber;
	}

	public String getAgeRestriction() {
		return ageRestriction;
	}

	public void setAgeRestriction(String ageRestriction) {
		this.ageRestriction = ageRestriction;
	}
	
	public String getEquipTech() {
		return equipTech;
	}

	public void setEquipTech(String equipTech) {
		this.equipTech = equipTech;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getCompletedState() {
		return completedState;
	}

	public void setCompletedState(String completedState) {
		this.completedState = completedState;
	}

	public String getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}

	public Integer getCompetitionInfoIx() {
		return competitionInfoIx;
	}

	public void setCompetitionInfoIx(Integer competitionInfoIx) {
		this.competitionInfoIx = competitionInfoIx;
	}
	
}
