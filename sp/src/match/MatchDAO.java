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
	
	//모임글 작성시에 입력하는 함수
	public int makeMoim(MatchDTO mdto) {
		try {
			conn = db.DB.getConn();
			String sql = "Insert into Match_TB values(Match_TB_SEQ.nextVal, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, mdto.getMemberIx());
			ps.setInt(2, mdto.getCompetitionInfoIx());
			ps.setString(3, mdto.getMatchName());
			ps.setString(4, mdto.getMainRole());
			ps.setString(5, mdto.getDetailRole());
			ps.setString(6, mdto.getOriginalMemberNumber());
			ps.setString(7, mdto.getSido());
			ps.setString(8, mdto.getSigungu());
			ps.setString(9, mdto.getTimesAWeek());
			ps.setString(10, mdto.getDay());
			ps.setString(11, mdto.getTotalWantedNumber());
			ps.setString(12, mdto.getAgeRestriction());
			ps.setString(13, mdto.getEquipTech());
			ps.setString(14, mdto.getDetail());
			ps.setString(15, "false");

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
	
	//모임생성 및 수정 데이터베이스 값 정의
	public MatchDTO MoimCardList(Integer competitionInfoIx){
		try {
			conn=db.DB.getConn();
			String sql="select * from Match_TB where Competition_Info_IX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, competitionInfoIx);
			rs=ps.executeQuery();
			MatchDTO dto=null;
			if(rs.next()) {
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
				java.sql.Date writeDate=rs.getDate("WRITE_DATE");
				dto=new MatchDTO(matchIx, memberIx, competitionInfoIx, matchName, mainRole, detailRole, originalMemberNumber, sido, sigungu, timesAWeek, day, totalWantedNumber, ageRestriction, equipTech, detail, completedState, writeDate);
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
	
	//여러개의 모임카드 DAO구성
	public ArrayList<MatchDTO> MoimCardAllList(Integer competitionInfoIx){
		try {
			conn=db.DB.getConn();
			String sql="select * from Match_TB where Competition_Info_IX=?";
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
				java.sql.Date writeDate=rs.getDate("WRITE_DATE");
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
	
	

	
	
	
}
