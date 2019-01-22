package match;

import java.sql.*;
import java.util.*;

public class MatchDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MatchDAO() {
		System.out.println("MatchDAO 생성");
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
				//구체적인 사항
				String detail=rs.getString("DETAIL");
				//완료 여부
				String completedState=rs.getString("COMPLETED_STATE");
				//공모전 글쓴 날짜
				String writeDate=rs.getString("WRITE_DATE");
				dto=new MatchDTO(matchIx, memberIx, competitionInfoIx, matchName, mainRole, detailRole, originalMemberNumber, sido, sigungu, timesAWeek, day, totalWantedNumber, ageRestriction, detail, completedState, writeDate);
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
	//공모전 모임카드 총인원 계산
	
	
}
