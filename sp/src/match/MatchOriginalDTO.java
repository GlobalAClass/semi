package match;

//모집 이전의 인원(모집 글 올리기 전에 함께 하고 있는 인원 = 현재 함께 하고 있는 인원) 
public class MatchOriginalDTO {

	    // 모집 이전의 인원 인덱스 
	    private Integer matchOriginalIx;

	    // 매칭 글 인덱스 
	    private Integer matchIx;

	    // 담당 역할-대분류 
	    private String ogMainRole;

	    // 담당 역할-소분류 
	    private String ogDetailRole;

	    // 해당 역할 인원 수 
	    private String memberNumber;
	    
	    // 기본 생성자
	    public MatchOriginalDTO() {
	    	System.out.println("MatchOriginalDTO 생성");
		}
	    
	    // 모든 필드 생성자
	    public MatchOriginalDTO(Integer matchOriginalIx, Integer matchIx, String ogMainRole, String ogDetailRole,
				String memberNumber) {
			super();
			this.matchOriginalIx = matchOriginalIx;
			this.matchIx = matchIx;
			this.ogMainRole = ogMainRole;
			this.ogDetailRole = ogDetailRole;
			this.memberNumber = memberNumber;
		}

	    public Integer getMatchOriginalIx() {
	        return matchOriginalIx;
	    }

		public void setMatchOriginalIx(Integer matchOriginalIx) {
	        this.matchOriginalIx = matchOriginalIx;
	    }

	    public Integer getMatchIx() {
	        return matchIx;
	    }

	    public void setMatchIx(Integer matchIx) {
	        this.matchIx = matchIx;
	    }

	    public String getogMainRole() {
	        return ogMainRole;
	    }

	    public void setogMainRole(String ogMainRole) {
	        this.ogMainRole = ogMainRole;
	    }

	    public String getogDetailRole() {
	        return ogDetailRole;
	    }

	    public void setogDetailRole(String ogDetailRole) {
	        this.ogDetailRole = ogDetailRole;
	    }

	    public String getmemberNumber() {
	        return memberNumber;
	    }

	    public void setmemberNumber(String memberNumber) {
	        this.memberNumber = memberNumber;
	    }
}
