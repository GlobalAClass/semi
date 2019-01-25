package member;

// 회원의 필수정보 
public class MemberDTO {

	// 회원 인덱스
	private Integer memberIx;

	// 이메일(=아이디)
	private String idEmail;

	// 비밀번호
	private String pwd;

	// 이름
	private String mName;

	// 이메일수신동의
	private String emailAgreement;

	// 분야/전공
	private String fieldMajor;

	// 생성자
	public MemberDTO() {
		System.out.println("MemberDTO 생성");
	}

	// 모든 필드를 가지는 생성자
	public MemberDTO(Integer memberIx, String idEmail, String pwd, String mName, String emailAgreement,
			String fieldMajor) {
		super();
		this.memberIx = memberIx;
		this.idEmail = idEmail;
		this.pwd = pwd;
		this.mName = mName;
		this.emailAgreement = emailAgreement;
		this.fieldMajor = fieldMajor;
	}
	// 인덱스를 제외한 생성자.
	public MemberDTO(String idEmail, String pwd, String mName, String emailAgreement, String fieldMajor) {
		super();
		this.idEmail = idEmail;
		this.pwd = pwd;
		this.mName = mName;
		this.emailAgreement = emailAgreement;
		this.fieldMajor = fieldMajor;
	}
	
	// 회원 인덱스, 회원의 이름, 전공, 이메일을 가지는 생성자
	public MemberDTO(Integer memberIx,String idEmail, String mName, String fieldMajor) {
		super();
		this.memberIx = memberIx;
		this.idEmail = idEmail;
		this.mName = mName;
		this.fieldMajor = fieldMajor;
	}


	public Integer getMemberIx() {
		return memberIx;
	}

	public void setMemberIx(Integer memberIx) {
		this.memberIx = memberIx;
	}

	public String getidEmail() {
		return idEmail;
	}

	public void setidEmail(String idEmail) {
		this.idEmail = idEmail;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getMName() {
		return mName;
	}

	public void setMName(String mName) {
		this.mName = mName;
	}

	public String getEmailAgreement() {
		return emailAgreement;
	}

	public void setEmailAgreement(String emailAgreement) {
		this.emailAgreement = emailAgreement;
	}

	public String getFieldMajor() {
		return fieldMajor;
	}

	public void setFieldMajor(String fieldMajor) {
		this.fieldMajor = fieldMajor;
	}
}
