package match;

import java.sql.*;
import java.util.*;
import member.MemberDTO;

public class MatchDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MatchDAO() {
		System.out.println("MatchDAO 생성");
	}
	
	// 회원 테이블의 다음 시퀀스 값 구하기.
	public int getMatchSEQUENCE() {
		try {
			System.out.println("getMemberSEQUENCE()호출");
			conn = db.DB.getConn();
			String sql = "select Member_TB_SEQ.nextval from dual";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			rs.next();
			return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
			return -1; // error = -1
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {

			}
		}
	}
	
	//모임글 작성시에 입력하는 함수
	public int makeMoim(MatchDTO mdto, int matchSEQ) {
		try {
			conn = db.DB.getConn();
			String sql = "Insert into Match_TB values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, matchSEQ);
			ps.setInt(2, mdto.getMemberIx());
			ps.setInt(3, mdto.getCompetitionInfoIx());
			ps.setString(4, mdto.getMatchName());
			ps.setString(5, mdto.getMainRole());
			ps.setString(6, mdto.getDetailRole());
			ps.setString(7, mdto.getOriginalMemberNumber());
			ps.setString(8, mdto.getSido());
			ps.setString(9, mdto.getSigungu());
			ps.setString(10, mdto.getTimesAWeek());
			ps.setString(11, mdto.getDay());
			ps.setString(12, mdto.getTotalWantedNumber());
			ps.setString(13, mdto.getAgeRestriction());
			ps.setString(14, mdto.getEquipTech());
			ps.setString(15, mdto.getDetail());
			ps.setString(16, "false");

			int count = ps.executeUpdate();
			return count;

		} catch (Exception e) {
			e.printStackTrace();
			return -1; // error = -1
		} finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {

			}
		}
	}
	
	//여러개의 모임카드 공모전인덱스받는 DAO구성
	public ArrayList<MatchDTO> MoimCardAllList(Integer competitionInfoIx){
		try {
			conn=db.DB.getConn();
			String sql="select m.*, to_char(m.WRITE_DATE,'yyyy-mm-dd, hh24:mi:ss') time from Match_TB m where Competition_Info_IX=? order by WRITE_DATE desc";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, competitionInfoIx);
			rs=ps.executeQuery();
			ArrayList<MatchDTO> arr=new ArrayList<MatchDTO>();
			while(rs.next()) {
				//매칭 글 인덱스
				Integer matchIx=rs.getInt("Match_IX");
				// 글 쓴 회원 인덱스
				Integer memberIx=rs.getInt("MEMBER_IX");
				//모임명
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
				MatchDTO dto=new MatchDTO(matchIx, memberIx, competitionInfoIx, matchName, mainRole, detailRole, originalMemberNumber, sido, sigungu, timesAWeek, day, totalWantedNumber, ageRestriction, equipTech, detail, completedState, writeDate);
				arr.add(dto);
			}
			return arr;
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
	
	//index 페이지 모임 최근올라온 목록보기 5개
		public ArrayList<MatchDTO> RecentMoimAllList(){
			try {
				conn=db.DB.getConn();
				String sql="select * from (select * from Match_TB order by WRITE_DATE desc) where rownum<=5";
				ps=conn.prepareStatement(sql);
				rs=ps.executeQuery();
				ArrayList<MatchDTO> arr=new ArrayList<MatchDTO>();
				while(rs.next()) {
					//매칭 글 인덱스
					Integer matchIx=rs.getInt("Match_IX");
					// 공모전 정보 인덱스
					Integer competitionInfoIx=rs.getInt("Competition_Info_IX");
					//모임명
					String matchName=rs.getString("MATCH_NAME");
					MatchDTO dto=new MatchDTO(matchIx,competitionInfoIx,matchName);
					arr.add(dto);
				}
				return arr;
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
	

	//하나의 모임 글 가져오기 --상세보기에서 쓰이는 함수.(CompetitionMoimSelet.jsp)
	public MatchDTO getMoimCard(Integer match_ix) {
		try {
			conn = db.DB.getConn();
			String sql = "select m.*, to_char(m.WRITE_DATE,'yyyy-mm-dd, hh24:mi:ss') time from Match_TB m where Match_IX=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, match_ix);
			rs = ps.executeQuery();
			
			MatchDTO dto = null;
			while (rs.next()) {
				// 매칭 글 인덱스
				Integer competitionInfoIx = rs.getInt("Competition_Info_IX");
				// 글 쓴 회원 인덱스
				Integer memberIx = rs.getInt("MEMBER_IX");
				// 모임명
				String matchName = rs.getString("MATCH_NAME");
				// 담당역할-대분류
				String mainRole = rs.getString("MAIN_ROLE");
				// 담당역할-소분류
				String detailRole = rs.getString("DETAIL_ROLE");
				// 현재 존재하는 팀원수
				String originalMemberNumber = rs.getString("ORIGINAL_MEMBER_NUMBER");
				// 시/도
				String sido = rs.getString("SIDO");
				// 시/군/구
				String sigungu = rs.getString("SIGUNGU");
				// 한주에 몇회의 모임
				String timesAWeek = rs.getString("TIMES_A_WEEK");
				// 요일
				String day = rs.getString("DAY");
				// 구하고 싶은 팀원수
				String totalWantedNumber = rs.getString("TOTAL_WANTED_NUMBER");
				// 나이제한
				String ageRestriction = rs.getString("AGE_RESTRICTION");
				// 장비/기술 사항
				String equipTech = rs.getString("EQUIP_TECH");
				// 구체적인 사항
				String detail = rs.getString("DETAIL");
				// 완료 여부
				String completedState = rs.getString("COMPLETED_STATE");
				// 공모전 글쓴 날짜
				String writeDate = rs.getString("TIME");
				dto = new MatchDTO(match_ix, memberIx, competitionInfoIx, matchName, mainRole, detailRole,
						originalMemberNumber, sido, sigungu, timesAWeek, day, totalWantedNumber, ageRestriction,
						equipTech, detail, completedState, writeDate);
			}
			return dto;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}
	
	//모임글 수정하기.
	public int modifyMoimCard(MatchDTO matchdto) {
		try {
			conn = db.DB.getConn();
			String sql = "UPDATE Match_TB SET MATCH_NAME = ?, MAIN_ROLE = ?, DETAIL_ROLE = ?, ORIGINAL_MEMBER_NUMBER = ?, "
						+"SIDO = ?, SIGUNGU = ?, TIMES_A_WEEK = ?, DAY = ?, TOTAL_WANTED_NUMBER = ?, AGE_RESTRICTION = ?, "
						+"EQUIP_TECH = ?, DETAIL = ?, WRITE_DATE = SYSDATE WHERE Match_IX = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, matchdto.getMatchName());
			ps.setString(2, matchdto.getMainRole());
			ps.setString(3, matchdto.getDetailRole());
			ps.setString(4, matchdto.getOriginalMemberNumber());
			ps.setString(5, matchdto.getSido());
			ps.setString(6, matchdto.getSigungu());
			ps.setString(7, matchdto.getTimesAWeek());
			ps.setString(8, matchdto.getDay());
			ps.setString(9, matchdto.getTotalWantedNumber());
			ps.setString(10, matchdto.getAgeRestriction());
			ps.setString(11, matchdto.getEquipTech());
			ps.setString(12, matchdto.getDetail());
			ps.setInt(13, matchdto.getMatchIx());
			int count = ps.executeUpdate();

			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1; 
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
			}
		}
	}
}