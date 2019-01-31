package msearch;

import java.util.*;
import competition.CompetitionInfoDTO;
import match.MatchDTO;
import java.sql.*;

public class MsearchDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MsearchDAO() {
		System.out.println("MsearchDAO 생성");
	}
	
	//part클래스 left / right 정의
	public Pairs<CompetitionInfoDTO,MatchDTO> Pairs(CompetitionInfoDTO cdto,MatchDTO mdto){
		Pairs<CompetitionInfoDTO,MatchDTO> pairs = new Pairs<CompetitionInfoDTO,MatchDTO>(cdto,mdto);
		return pairs;
	}
	//모임검색 모임카드 정보 받기 DAO
	public ArrayList<Pairs<CompetitionInfoDTO,MatchDTO>> MoimSearch(String sidos,String sigungus,String CField){
		try {
			conn=db.DB.getConn();
			String sql="select a.C_NAME,a.FIELD,b.*, to_char(b.WRITE_DATE,'yyyy-mm-dd, hh24:mi:ss') time from Competition_Info_TB a,Match_TB b where a.Competition_Info_IX=b.Competition_Info_IX";
			if(!(sidos==null||sidos.equals("")||sidos.equals("undefiend"))) {
				sql +=" AND b.SIDO='"+sidos+"'";
				if(!(sigungus==null||sigungus.equals("")||sigungus.equals("undefiend"))) {
					sql +=" AND b.SIGUNGU='"+sigungus+"'";
					}
			}
			if(!(CField==null||CField.equals("")||CField.equals("undefiend"))) {
				sql +=" AND a.FIELD='"+CField+"'";
			}
			sql += " ORDER BY WRITE_DATE desc";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<Pairs<CompetitionInfoDTO,MatchDTO>> search=new ArrayList<Pairs<CompetitionInfoDTO,MatchDTO>>();
			if(rs.next()) {
				do {
				//left
				Integer competitionInfoIx_=rs.getInt("Competition_Info_IX");
				String CName=rs.getString("C_NAME");
				String field=rs.getString("FIELD");
				//right
				Integer matchIx=rs.getInt("Match_IX");
				Integer memberIx=rs.getInt("MEMBER_IX");
				Integer competitionInfoIx=rs.getInt("Competition_Info_IX");
				String matchName=rs.getString("MATCH_NAME");
				String mainRole=rs.getString("MAIN_ROLE");
				String detailRole=rs.getString("DETAIL_ROLE");
				String originalMemberNumber=rs.getString("ORIGINAL_MEMBER_NUMBER");
				String sido=rs.getString("SIDO");
				String sigungu=rs.getString("SIGUNGU");
				String timesAWeek=rs.getString("TIMES_A_WEEK");
				String day=rs.getString("DAY");
				String totalWantedNumber=rs.getString("TOTAL_WANTED_NUMBER");
				String ageRestriction=rs.getString("AGE_RESTRICTION");
				String equipTech=rs.getString("EQUIP_TECH");
				String detail=rs.getString("DETAIL");
				String completedState=rs.getString("COMPLETED_STATE");
				String writeDate=rs.getString("TIME");
				
				CompetitionInfoDTO cdto=new CompetitionInfoDTO(competitionInfoIx_,CName, field);
				MatchDTO mdto=new MatchDTO(matchIx, memberIx, competitionInfoIx, matchName, mainRole, detailRole, originalMemberNumber, sido, sigungu, timesAWeek, day, totalWantedNumber, ageRestriction, equipTech, detail, completedState, writeDate);
				search.add(Pairs(cdto,mdto));
				}while(rs.next());
			}
			return search;
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
