package msearch;

import java.util.*;
import competition.CompetitionInfoDTO;
import match.MatchDTO;
import java.sql.*;

public class MsearchDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	//모임검색 모임카드 정보 받기 DAO
	public ArrayList<MatchDTO> MoimSearchCard(){
		try {
			conn=db.DB.getConn();
			String sql="select m.*, to_char(m.WRITE_DATE,'yyyy-mm-dd, hh24:mi:ss') time from Match_TB m order by Match_IX desc";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<MatchDTO> arr=new ArrayList<MatchDTO>();
			while(rs.next()) {
				//매칭 글 인덱스
				Integer matchIx=rs.getInt("Match_IX");
				// 글 쓴 회원 인덱스
				Integer memberIx=rs.getInt("MEMBER_IX");
				//모임명
				String matchName=rs.getString("MATCH_NAME");
				//시도
				String sido=rs.getString("SIDO");
				//시군구
				String sigungu=rs.getString("SIGUNGU");
				//현재 존재하는 팀원수
				String originalMemberNumber=rs.getString("ORIGINAL_MEMBER_NUMBER");
				//구하고 싶은 팀원수
				String totalWantedNumber=rs.getString("TOTAL_WANTED_NUMBER");
				//공모전 글쓴 날짜
				String writeDate=rs.getString("TIME");
				MatchDTO dto=new MatchDTO(matchIx, memberIx, matchName, originalMemberNumber, sido, sigungu, totalWantedNumber, writeDate);
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
		
	//모임검색 	모임카드 공모전 정보 가져오기 DAO
	public CompetitionInfoDTO CompetitionMoimSearchCard(Integer matchIx) {
		try {
			conn=db.DB.getConn();
			String sql="select * from Competition_Info_TB where Competition_Info_IX=(select Competition_Info_IX from Match_TB where MATCH_IX=?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, matchIx);
			rs=ps.executeQuery();
			CompetitionInfoDTO dto=null;
			if(rs.next()) {
				//공모전 정보 인덱스
				Integer competitionInfoIx=rs.getInt("Competition_Info_IX");
				//공모전 제목
				String CName=rs.getString("C_NAME");
				//분야
				String field=rs.getString("FIELD");
				//공모전 조회수
				Integer readnum=rs.getInt("READNUM");
				dto=new CompetitionInfoDTO(competitionInfoIx, CName, field, readnum);
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
		
		
		
		
		
}
