package member;

//회원의 추가정보
public class MemberDetailDTO {

	// 회원 추가정보 인덱스
	private Integer memberDetailIx;

	// 회원 인덱스
	private Integer memberIx;

	// 핸드폰번호
	private String contact;
	
	// 핸드폰 번호 공개 동의
	private String contactAgreement;
	
	// 카카오ID
	private String kakaoId;
	
	// 카카오ID 공개 동의
	private String kakaoIdAgreement;
	
	// 출생년도
	private String birthYear;

	// 시/도
	private String sido;

	// 시/군/구
	private String sigungu;

	// 자기소개
	private String mProfile;

	// 기본 생성자
	public MemberDetailDTO() {
		System.out.println("MemberDetailDTO 생성");
	}

	// 모든 필드를 가지는 생성자.
	public MemberDetailDTO(Integer memberDetailIx, Integer memberIx, String contact, String contactAgreement, 
			String kakaoId, String kakaoIdAgreement,String birthYear,
			String sido, String sigungu, String mProfile) {
		super();
		this.memberDetailIx = memberDetailIx;
		this.memberIx = memberIx;
		this.contact = contact;
		this.contactAgreement = contactAgreement;
		this.kakaoId = kakaoId;
		this.kakaoIdAgreement = kakaoIdAgreement;
		this.birthYear = birthYear;
		this.sido = sido;
		this.sigungu = sigungu;
		this.mProfile = mProfile;
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

	public String getContactAgreement() {
		return contactAgreement;
	}

	public void setContactAgreement(String contactAgreement) {
		this.contactAgreement = contactAgreement;
	}

	public String getKakaoId() {
		return kakaoId;
	}

	public void setKakaoId(String kakaoId) {
		this.kakaoId = kakaoId;
	}
	
	public String getKakaoIdAgreement() {
		return kakaoIdAgreement;
	}

	public void setKakaoIdAgreement(String kakaoIdAgreement) {
		this.kakaoIdAgreement = kakaoIdAgreement;
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

	public String getmProfile() {
		return mProfile;
	}

	public void setmProfile(String mProfile) {
		this.mProfile = mProfile;
	}

}
