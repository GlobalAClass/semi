package match;

//모집 이전의 인원(모집 글 올리기 전에 함께 하고 있는 인원 = 현재 함께 하고 있는 인원) 
public class MatchOriginalDTO {

	    // 모집 이전의 인원 인덱스 
	    private Integer matchOriginalIx;

	    // 매칭 글 인덱스 
	    private Integer matchIx;

	    // 담당 역할-대분류 
	    private String mainRole;

	    // 담당 역할-소분류 
	    private String detailRole;

	    // 해당 역할 인원 수 
	    private String memberNumber;
	    
	    // 기본 생성자
	    public MatchOriginalDTO() {
	    	System.out.println("MatchOriginalDTO 생성");
		}
	    
	    // 모든 필드 생성자
	    public MatchOriginalDTO(Integer matchOriginalIx, Integer matchIx, String mainRole, String detailRole,
				String memberNumber) {
			super();
			this.matchOriginalIx = matchOriginalIx;
			this.matchIx = matchIx;
			this.mainRole = mainRole;
			this.detailRole = detailRole;
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

	    public String getmemberNumber() {
	        return memberNumber;
	    }

	    public void setmemberNumber(String memberNumber) {
	        this.memberNumber = memberNumber;
	    }
}
