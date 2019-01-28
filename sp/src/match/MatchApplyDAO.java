package match;

import java.sql.*;
import java.util.ArrayList;

import member.MemberDTO;
import member.MemberDetailDTO;

public class MatchApplyDAO {
	private static final int ERROR = -1;
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MatchApplyDAO() {
		System.out.println("MatctApplyDAO 생성");
	}
	
	//match_idx에 따라 글쓴 사람의 기본정보 받아오는 메소드
	public MemberDTO writeInfo(int match_idx) {
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT M.* FROM MEMBER_TB M, MATCH_TB MT WHERE MT.MATCH_IX=? AND M.MEMBER_IX=MT.MEMBER_IX";
			ps=conn.prepareStatement(sql);
			ps.setInt(1,match_idx);
			
			rs = ps.executeQuery();
			
			MemberDTO dto = new MemberDTO();
			if(rs.next()) {
				String idEmail = rs.getString("ID_EMAIL");
				String pwd = rs.getString("PWD");
				String mName = rs.getString("M_NAME");
				String emailAgreement = rs.getString("EMAIL_AGREEMENT");
				String fieldMajor = rs.getString("FIELD_MAJOR");
				
				dto = new MemberDTO(idEmail, pwd, mName, emailAgreement, fieldMajor);
			}
			return dto;
			
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	//match_idx에 따라 글쓴 사람의 세부정보 받아오는 메소드
	public MemberDetailDTO writeDetailInfo(int match_idx) {
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT MD.* FROM MEMBER_DETAIL_TB MD, MATCH_TB MT WHERE MT.MATCH_IX=? AND MD.MEMBER_IX=MT.MEMBER_IX";
			
			ps=conn.prepareStatement(sql);
			ps.setInt(1, match_idx);
			
			rs = ps.executeQuery();
			
			MemberDetailDTO dto = new MemberDetailDTO();
			if(rs.next()) {
				String contact = rs.getString("CONTACT");
				String contactAgreement = rs.getString("CONTACT_AGREEMENT");
				String kakaoId = rs.getString("KAKAO_ID");
				String kakaoIdAgreement = rs.getString("KAKAO_ID_AGREEMENT");
				String birthYear = rs.getString("BIRTH_YEAR");
				String sido = rs.getString("SIDO");
				String sigungu = rs.getString("SIGUNGU");
				String mProfile = rs.getString("M_PROFILE");
				String searchAgreement = rs.getString("SEARCH_AGREEMENT");
			
				dto = new MemberDetailDTO(contact, contactAgreement, kakaoId, kakaoIdAgreement, birthYear, sido, sigungu, mProfile, searchAgreement);
			}
			return dto;
			
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	//match_idx에 따라 테이블에 존재하는 매칭정보 값 받아오는 메소드
	public MatchDTO matchInfo(int match_idx) {
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT M.*, TO_CHAR(M.WRITE_DATE,'YYYY-MM-DD, HH24:MI:SS') TIME FROM MATCH_TB M WHERE MATCH_IX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, match_idx);
			
			rs=ps.executeQuery();
			
			MatchDTO dto = new MatchDTO();
			if(rs.next()) {
				String matchName=rs.getString("MATCH_NAME");
				//담당역할-대분류
				String mainRole=rs.getString("MAIN_ROLE");
				//담당역할-소분류
				String detailRole=rs.getString("DETAIL_ROLE");
				//현재 존재하는 팀원수
				String originalMemberNumber=rs.getString("ORIGINAL_MEMBER_NUMBER");
				// 시/도
				String sido=rs.getString("SIDO");
				// 시/군/구
				String sigungu=rs.getString("SIGUNGU");
				//한주에 몇회의 모임
				String timesAWeek=rs.getString("TIMES_A_WEEK");
				//요일
				String day=rs.getString("DAY");
				//구하고 싶은 팀원수
				String totalWantedNumber=rs.getString("TOTAL_WANTED_NUMBER");
				//나이제한
				String ageRestriction=rs.getString("AGE_RESTRICTION");
				//장비/기술 사항
				String equipTech=rs.getString("EQUIP_TECH");
				//구체적인 사항
				String detail=rs.getString("DETAIL");
				//완료 여부
				String completedState=rs.getString("COMPLETED_STATE");
				//공모전 글쓴 날짜
				String writeDate=rs.getString("TIME");
				
				dto = new MatchDTO(matchName, mainRole, detailRole, originalMemberNumber, sido, sigungu, timesAWeek, day, totalWantedNumber, ageRestriction, equipTech, detail, completedState, writeDate);
						
			}
			return dto;
			
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	//match_idx에 따라서 기존에 존재하는 멤버들 가져오는 메소드
	public ArrayList<MatchOriginalDTO> matchOriginalInfo(int match_idx){
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT * FROM MATCH_ORIGINAL_TB WHERE MATCH_IX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, match_idx);
			
			rs=ps.executeQuery();
			
			ArrayList<MatchOriginalDTO> list = new ArrayList<MatchOriginalDTO>();
			
			if(rs.next()) {
				do {
					String ogMainRole = rs.getString("OG_MAIN_ROLE");
					String ogDetailRole = rs.getString("OG_DETAIL_ROLE");
					String memberNumber = rs.getString("MEMBER_NUMBER");
					
					MatchOriginalDTO dto = new MatchOriginalDTO(ogMainRole, ogDetailRole, memberNumber);
					list.add(dto);
					
				}while(rs.next());
			}
			
			return list;
		
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	//매칭 지원한 역할의 세부사항에 대한 정보를 가져오는 메소드
	public MatchWantedDTO matchWantedInfo(int match_wanted_ix) {
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT * FROM MATCH_WANTED_TB WHERE MATCH_WANTED_IX=?";
			
			ps=conn.prepareStatement(sql);
			ps.setInt(1, match_wanted_ix);
			
			rs=ps.executeQuery();
			
			MatchWantedDTO dto = new MatchWantedDTO();
			if(rs.next()) {
				String wMainRole=rs.getString("W_MAIN_ROLE");
				String wDetailRole=rs.getString("W_DETAIL_ROLE");
				String requiredAbility=rs.getString("REQUIRED_ABILITY");
				
				dto = new MatchWantedDTO(wMainRole, wDetailRole, requiredAbility);
				
			}
			return dto;
			
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	
	//모임 지원글 저장하는 메소드
	public int matchApplyInsert(MatchApplyDTO applydto) {
		try {
			conn=db.DB.getConn();
			
			String sql="INSERT INTO MATCH_APPLY_TB VALUES(Match_Apply_TB_SEQ.NEXTVAL,?,?,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, applydto.getMemberIx());
			ps.setInt(2, applydto.getMatchIx());
			ps.setInt(3, applydto.getMatchWantedIx());
			ps.setString(4, applydto.getAboutApplicant());
			ps.setString(5, applydto.getOtherExC());
			
			int count = ps.executeUpdate();
			return count;
			
		}catch(Exception e) {
			e.printStackTrace();
			return ERROR;
		}finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			}catch(Exception e2) {}
		}
	}
	
	
	// match_wanted_ix로 matchapplyDTO 가져오는 함수 - CompetitionMoimSelect.jsp에 쓰임.
	// 로그인한 유저가 지원서를 작성했는지 여부를 판단하기 위한 함수.
	public boolean areYouApply(int match_wanted_ix, int member_ix) {
		try {
			conn = db.DB.getConn();
			String sql = "SELECT 1 FROM (SELECT MEMBER_IX FROM Match_Apply_TB WHERE MATCH_WANTED_IX = "+match_wanted_ix+" ) WHERE MEMBER_IX = "+member_ix;

			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			if (rs.next()) {
				return true; //지원자
			}else {
				return false; //지원 안함
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		} finally {
			try {
				if (rs != null)rs.close();
				if (ps != null)ps.close();
				if (conn != null)conn.close();
			} catch (Exception e2) {
			}
		}
	}
}
