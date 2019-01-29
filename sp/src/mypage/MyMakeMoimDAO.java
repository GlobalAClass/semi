package mypage;

import java.util.*;

import competition.CompetitionInfoDTO;
import match.*;
import member.MemberDTO;

import java.io.File;
import java.sql.*;

public class MyMakeMoimDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MyMakeMoimDAO() {
	}
	
	//내가 만든 모임 인덱스, 모임명 가져오는 메소드
	public ArrayList<MatchDTO> makeMoimInfo(int member_ix) {
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT MATCH_IX, MATCH_NAME, MAIN_ROLE, DETAIL_ROLE, COMPLETED_STATE FROM MATCH_TB WHERE MEMBER_IX=? ORDER BY MATCH_IX DESC";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, member_ix);
			
			rs=ps.executeQuery();
			
			ArrayList<MatchDTO> arr = new ArrayList<MatchDTO>();
			if(rs.next()) {
				do {
					int matchIx = rs.getInt("MATCH_IX");
					String matchName = rs.getString("MATCH_NAME");
					String mainRole = rs.getString("MAIN_ROLE");
					String detailRole = rs.getString("DETAIL_ROLE");
					String completedState = rs.getString("COMPLETED_STATE");
					
					MatchDTO dto = new MatchDTO(matchIx, matchName, mainRole, detailRole, completedState);
					arr.add(dto);
				}while(rs.next());
			}
			return arr;
			
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			}catch(Exception e2) {}
		}
	}
	
	//공모전 인덱스, 공모전명 가져오는 메소드
	public ArrayList<CompetitionInfoDTO> makeMoimCompInfo(int member_ix) {
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT C.COMPETITION_INFO_IX, C.C_NAME FROM COMPETITION_INFO_TB C, MATCH_TB M WHERE M.MEMBER_IX=? AND M.COMPETITION_INFO_IX = C.COMPETITION_INFO_IX ORDER BY M.MATCH_IX DESC";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, member_ix);
			
			rs=ps.executeQuery();
			
			ArrayList<CompetitionInfoDTO> arr = new ArrayList<CompetitionInfoDTO>();
			if(rs.next()) {
				do {
					int competitionInfoIx = rs.getInt("COMPETITION_INFO_IX");
					String cName = rs.getString("C_NAME");
					
					CompetitionInfoDTO dto = new CompetitionInfoDTO(competitionInfoIx, cName);
					arr.add(dto);
				}while(rs.next());
			}
			return arr;
			
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			}catch(Exception e2) {}
		}
	}
	
	//기존에 모임에 참여하고 있는 사람들의 역할과 명수 가져오는 메소드
	public ArrayList<MatchOriginalDTO> moimOriginInfo(int match_ix){
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT MO.OG_MAIN_ROLE, MO.OG_DETAIL_ROLE, MO.MEMBER_NUMBER FROM MATCH_ORIGINAL_TB MO, MATCH_TB M WHERE MO.MATCH_IX=? AND M.MATCH_IX=MO.MATCH_IX";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, match_ix);
			
			rs=ps.executeQuery();
			
			ArrayList<MatchOriginalDTO> arr = new ArrayList<MatchOriginalDTO>();
			if(rs.next()) {
				do {
					String ogMainRole = rs.getString("OG_MAIN_ROLE");
					String ogDetailRole = rs.getString("OG_DETAIL_ROLE");
					String memberNumber = rs.getString("MEMBER_NUMBER");
					
					MatchOriginalDTO dto = new MatchOriginalDTO(ogMainRole, ogDetailRole, memberNumber);
					arr.add(dto);
				}while(rs.next());
			}
			return arr;
			
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			}catch(Exception e2) {}
		}
	}
	
	//해당 모임글에 신청한 사람의 회원 인덱스와 이름 가져오는 메소드
	public ArrayList<MemberDTO> moimApplyInfo(int match_ix){
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT M.MEMBER_IX, M.M_NAME FROM MEMBER_TB M,MATCH_APPLY_TB MA WHERE MA.MATCH_IX=? AND MA.MEMBER_IX=M.MEMBER_IX ORDER BY MA.MATCH_APPLY_IX DESC";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, match_ix);
			
			rs=ps.executeQuery();
			
			ArrayList<MemberDTO> arr = new ArrayList<MemberDTO>();
			if(rs.next()) {
				do {
					int memberIx = rs.getInt("MEMBER_IX");
					String mName = rs.getString("M_NAME");
					
					MemberDTO dto = new MemberDTO(memberIx, mName);
					
					arr.add(dto);
				}while(rs.next());
			}
			return arr;
			
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			}catch(Exception e2) {}
		}
	}
	
	//해당 모임글에 신청한 사람의 담당역할 가져오는 메소드
	public ArrayList<MatchWantedDTO> moimApplyRole(int match_ix){
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT MW.W_MAIN_ROLE, MW.W_DETAIL_ROLE,MW.REQUIRED_ABILITY FROM MATCH_WANTED_TB MW, MATCH_APPLY_TB MA WHERE MA.MATCH_IX=? AND MW.MATCH_WANTED_IX=MA.MATCH_WANTED_IX ORDER BY MA.MATCH_APPLY_IX DESC";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, match_ix);
			
			rs=ps.executeQuery();
			
			ArrayList<MatchWantedDTO> arr = new ArrayList<MatchWantedDTO>();
			if(rs.next()) {
				do {
					String wMainRole = rs.getString("W_MAIN_ROLE");
					String wDetailRole = rs.getString("W_DETAIL_ROLE");
					String requiredAbility = rs.getString("REQUIRED_ABILITY");
					
					MatchWantedDTO dto = new MatchWantedDTO(wMainRole, wDetailRole, requiredAbility);
					arr.add(dto);
				}while(rs.next());
			}
			return arr;
			
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			}catch(Exception e2) {}
		}
	}
	
	//해당 모임글에 대한 인덱스 가져오는 메소드
	public int[] moimApplyIdx(int match_ix){
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT MATCH_APPLY_IX FROM MATCH_APPLY_TB WHERE MATCH_IX=? ORDER BY MATCH_APPLY_IX DESC";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, match_ix);
			
			rs=ps.executeQuery();
			
			Vector<Integer> v = new Vector<Integer>();
			while(rs.next()) {
				int temp = rs.getInt("MATCH_APPLY_IX");
				v.add(temp);
			}

			int arr[]=new int[v.size()];
	
			for(int i=0;i<arr.length;i++) {
				arr[i]=v.get(i);
			}
			
			return arr;
			
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			}catch(Exception e2) {}
		}
	}
	
	//프로필 설정하는 메소드
	public String setProfile(int member_ix, String path) {
		File userdir = new File(path+member_ix);
		File[] files = userdir.listFiles();
		String imagpath;
		if(files.length>0){
			imagpath = "/sp/img/profile/"+member_ix+"/"+files[0].getName();
		}else{
			imagpath = "/sp/img/profile_default.jpg";
		}
		return imagpath;
	}
	
	//직업마다 색깔 다르게 설정하는 메소드
	public String[] setRoleColor(String a_mainRole) {
		//직업마다 색깔 다르게 주기 위한 조건
		String arr[]=new String[2];
		
		if("developer".equals(a_mainRole)){
			arr[0] = "#0B0B61";
			arr[1] = "#E0E0F8";
		}else if("desiner".equals(a_mainRole)){
			arr[0] = "#610B4B";
			arr[1] = "#F8E0EC";
		}else if("planner".equals(a_mainRole)){
			arr[0] = "##0B3B0B";
			arr[1] = "#E0F8E0";
		}else{
			arr[0] = "#2E2E2E";
			arr[1] = "#F2F2F2";
		}
		
		return arr;
	}
	
}
