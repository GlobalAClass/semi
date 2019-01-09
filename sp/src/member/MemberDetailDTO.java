package member;

//회원의 추가정보
public class MemberDetailDTO {

	// 회원 추가정보 인덱스
	private Integer memberDetailIx;

	// 회원 인덱스
	private Integer memberIx;

	// 핸드폰번호
	private String contact;

	// 카카오ID
	private String kakaoId;

	// 출생년도
	private String birthYear;

	// 시/도
	private String sido;

	// 시/군/구
	private String sigungu;

	// 자기소개
	private String profile;

	// 프로필 사진 경로
	private String profilePicturePath;

	// 추가내용 공개/비공개
	private String infoOpen;

	// 기본 생성자
	public MemberDetailDTO() {
		System.out.println("MemberDetailDTO 생성");
	}

	// 모든 필드를 가지는 생성자.
	public MemberDetailDTO(Integer memberDetailIx, Integer memberIx, String contact, String kakaoId, String birthYear,
			String sido, String sigungu, String profile, String profilePicturePath, String infoOpen) {
		super();
		this.memberDetailIx = memberDetailIx;
		this.memberIx = memberIx;
		this.contact = contact;
		this.kakaoId = kakaoId;
		this.birthYear = birthYear;
		this.sido = sido;
		this.sigungu = sigungu;
		this.profile = profile;
		this.profilePicturePath = profilePicturePath;
		this.infoOpen = infoOpen;
	}

	public Integer getMemberDetailIx() {
		return memberDetailIx;
	}

	public void setMemberDetailIx(Integer memberDetailIx) {
		this.memberDetailIx = memberDetailIx;
	}

	public Integer getMemberIx() {
		return memberIx;
	}

	public void setMemberIx(Integer memberIx) {
		this.memberIx = memberIx;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getKakaoId() {
		return kakaoId;
	}

	public void setKakaoId(String kakaoId) {
		this.kakaoId = kakaoId;
	}

	public String getBirthYear() {
		return birthYear;
	}

	public void setBirthYear(String birthYear) {
		this.birthYear = birthYear;
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

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getProfilePicturePath() {
		return profilePicturePath;
	}

	public void setProfilePicturePath(String profilePicturePath) {
		this.profilePicturePath = profilePicturePath;
	}

	public String getInfoOpen() {
		return infoOpen;
	}

	public void setInfoOpen(String infoOpen) {
		this.infoOpen = infoOpen;
	}

}
