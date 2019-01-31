package msearch;

import java.util.*;
import competition.CompetitionInfoDTO;
import match.MatchDTO;
import match.MatchWantedDTO;
import java.sql.*;

public class MsearchDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MsearchDAO() {
		System.out.println("MsearchDAO 생성");
	}
	
	//part클래스 left / middle / right 정의
	public Pairs<CompetitionInfoDTO,MatchDTO,MatchWantedDTO> Part(CompetitionInfoDTO cdto,MatchDTO mdto,MatchWantedDTO mwdto){
		Pairs<CompetitionInfoDTO,MatchDTO,MatchWantedDTO> part = new Pairs<CompetitionInfoDTO,MatchDTO,MatchWantedDTO>(cdto,mdto,mwdto);
		return part;
	}
	//모임검색 모임카드 정보 받기 DAO
	public ArrayList<Pairs<CompetitionInfoDTO,MatchDTO,MatchWantedDTO>> MoimSearch(String sidos,String sigungus,String CField,String wMainRoles,String wDetailRoles){
		try {
			conn=db.DB.getConn();
			String sql="select a.C_NAME,a.FIELD,b.*, to_char(b.WRITE_DATE,'yyyy-mm-dd, hh24:mi:ss') time,c.* from Competition_Info_TB a,Match_TB b,Match_Wanted_TB c where b.Competition_Info_IX=a.Competition_Info_IX and b.Match_IX=c.Match_IX";
			if(!(sidos==null||sidos.equals("")||sidos.equals("undefiend"))) {
				sql +=" AND b.SIDO='"+sidos+"'";
				if(!(sigungus==null||sigungus.equals("")||sigungus.equals("undefiend"))) {
					sql +=" AND b.SIGUNGU='"+sigungus+"'";
					}
			}
			if(!(CField==null||CField.equals("")||CField.equals("undefiend"))) {
				sql +=" AND a.FIELD='"+CField+"'";
			}
			if(!(wMainRoles==null||wMainRoles.equals("")||wMainRoles.equals("undefiend"))) {
				sql +=" AND c.W_MAIN_ROLE='"+wMainRoles+"'";
			}
			if(!(wDetailRoles==null||wDetailRoles.equals("")||wDetailRoles.equals("undefiend"))) {
				sql +=" AND c.W_DETAIL_ROLE='"+wDetailRoles+"'";
			}
			sql += " ORDER BY WRITE_DATE desc";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<Pairs<CompetitionInfoDTO,MatchDTO,MatchWantedDTO>> search=new ArrayList<Pairs<CompetitionInfoDTO,MatchDTO,MatchWantedDTO>>();
			if(rs.next()) {
				do {
				//left
				Integer competitionInfoIx_=rs.getInt("Competition_Info_IX");
				String CName=rs.getString("C_NAME");
				String field=rs.getString("FIELD");
				//middle
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
				//right
				Integer matchWantedIx=rs.getInt("Match_Wanted_IX");
				Integer matchIx_=rs.getInt("Match_IX");
				String wMainRole=rs.getString("W_MAIN_ROLE");
				String wDetailRole=rs.getString("W_DETAIL_ROLE");
				String requiredAbility=rs.getString("REQUIRED_ABILITY");
				String wantedNumber=rs.getString("WANTED_NUMBER");
				String recruitedNumber=rs.getString("RECRUITED_NUMBER");
				
				CompetitionInfoDTO cdto=new CompetitionInfoDTO(competitionInfoIx_,CName, field);
				MatchDTO mdto=new MatchDTO(matchIx, memberIx, competitionInfoIx, matchName, mainRole, detailRole, originalMemberNumber, sido, sigungu, timesAWeek, day, totalWantedNumber, ageRestriction, equipTech, detail, completedState, writeDate);
				MatchWantedDTO mwdto=new MatchWantedDTO(matchWantedIx, matchIx_,wMainRole, wDetailRole, requiredAbility, wantedNumber, recruitedNumber);
				search.add(Part(cdto,mdto,mwdto));
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
