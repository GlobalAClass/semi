package hsearch;

// 사람 스크랩 
public class HumanScrapDTO {

	// 사람 스크랩 인덱스
	private Integer humanScrapIx;

	// 스크랩한 회원 인덱스
	private Integer memberIx;

	// 스크랩 당한 사람 인덱스
	private Integer scrapMemberIx;
	
	public HumanScrapDTO() {
		System.out.println("HumanScrapDTO 생성");
	}
	
	//모든 필드를 가지는 생성자.
	public HumanScrapDTO(Integer humanScrapIx, Integer memberIx, Integer scrapMemberIx) {
		super();
		this.humanScrapIx = humanScrapIx;
		this.memberIx = memberIx;
		this.scrapMemberIx = scrapMemberIx;
	}
	//테이블 인덱스를 제외한 생성자.
	public HumanScrapDTO(Integer memberIx, Integer scrapMemberIx) {
		super();
		this.memberIx = memberIx;
		this.scrapMemberIx = scrapMemberIx;
	}	

	public Integer getHumanScrapIx() {
		return humanScrapIx;
	}

	public void setHumanScrapIx(Integer humanScrapIx) {
		this.humanScrapIx = humanScrapIx;
	}

	public Integer getMemberIx() {
		return memberIx;
	}

	public void setMemberIx(Integer memberIx) {
		this.memberIx = memberIx;
	}

	public Integer getScrapMemberIx() {
		return scrapMemberIx;
	}

	public void setScrapMemberIx(Integer scrapMemberIx) {
		this.scrapMemberIx = scrapMemberIx;
	}

}
