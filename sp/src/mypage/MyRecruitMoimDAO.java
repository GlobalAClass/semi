package mypage;

import java.util.*;

import match.MatchDTO;
import match.MatchWantedDTO;
import member.MemberDTO;

import java.sql.*;

public class MyRecruitMoimDAO {
	
	private static final int ERROR = -1;

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MyRecruitMoimDAO() {
	}
	
	public int[] recruitApplyidx(int member_ix) {
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT MATCH_APPLY_IX FROM MATCH_APPLY_TB WHERE MEMBER_IX=? ORDER BY MATCH_APPLY_IX ASC";
			
			ps=conn.prepareStatement(sql);
			ps.setInt(1, member_ix);
			
			rs = ps.executeQuery();
			
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
	
	//모임 개설자 인덱스, 이름 구하는 메소드
	public ArrayList<MemberDTO> recruitMoimMakeName(int member_ix) {
		try {
			conn=db.DB.getConn();

			String sql = "SELECT MB.MEMBER_IX,MB.M_NAME FROM MEMBER_TB MB, MATCH_APPLY_TB MA, MATCH_TB M WHERE MA.MEMBER_IX=? AND MA.MATCH_IX=M.MATCH_IX AND MB.MEMBER_IX=M.MEMBER_IX ORDER BY MB.MEMBER_IX DESC";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_ix);
			
			rs=ps.executeQuery();
			
			ArrayList<MemberDTO> arr = new ArrayList<MemberDTO>();
			while(rs.next()) {
				int memberIx = rs.getInt("MEMBER_IX");
				String mName = rs.getString("M_NAME");
				
				MemberDTO dto = new MemberDTO(memberIx, mName);
				
				arr.add(dto);
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
	
	
	//모임 진행중인지 여부, 모임명 구하는 메소드
	public ArrayList<MatchDTO> recruitMoimName(int member_ix) {
		try {
			conn=db.DB.getConn();

			String sql = "SELECT M.MATCH_IX, M.COMPLETED_STATE, M.MATCH_NAME FROM MATCH_APPLY_TB MA, MATCH_TB M WHERE MA.MEMBER_IX=? AND MA.MATCH_IX=M.MATCH_IX ORDER BY M.MATCH_IX DESC";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_ix);
			
			rs=ps.executeQuery();
			
			ArrayList<MatchDTO> arr = new ArrayList<MatchDTO>();
			while(rs.next()) {
				int matchIx = rs.getInt("MATCH_IX");
				String matchName = rs.getString("MATCH_NAME");
				String completedState = rs.getString("COMPLETED_STATE");
				
				MatchDTO dto = new MatchDTO(matchIx, matchName, completedState);
				
				arr.add(dto);
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
	
	
	//공모전명 구하는 메소드
	public String[] recruitCompName(int member_ix) {
		try {
			conn=db.DB.getConn();

			String sql = "SELECT C.C_NAME FROM COMPETITION_INFO_TB C, MATCH_APPLY_TB MA, MATCH_TB M WHERE MA.MEMBER_IX=? AND MA.MATCH_IX=M.MATCH_IX AND C.COMPETITION_INFO_IX=M.COMPETITION_INFO_IX ORDER BY C.COMPETITION_INFO_IX DESC";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_ix);
			
			rs=ps.executeQuery();
			
			Vector<String> v = new Vector<String>();
			if(rs.next()) {
				do{
					String state=rs.getString("C_NAME");
					v.add(state);
				}while(rs.next());
			}
			
			String arr[]=new String[v.size()];
			
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
	
	//해당 모임 지원 시 가지게된 idx와 어떤 역할을 지원했는지 가져오는 메소드
	public ArrayList<MatchWantedDTO> recruitWanted(int member_ix) {
		try {
			conn=db.DB.getConn();

			String sql = "SELECT MW.MATCH_WANTED_IX, MW.W_MAIN_ROLE, MW.W_DETAIL_ROLE FROM MATCH_WANTED_TB MW, MATCH_APPLY_TB MA WHERE MA.MEMBER_IX=? AND MW.MATCH_WANTED_IX=MA.MATCH_WANTED_IX ORDER BY MW.MATCH_WANTED_IX DESC";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_ix);
			
			rs=ps.executeQuery();
			
			ArrayList<MatchWantedDTO> arr = new ArrayList<MatchWantedDTO>();
			while(rs.next()) {
				int matchWantedIx =rs.getInt("MATCH_WANTED_IX");
				String wMainRole = rs.getString("W_MAIN_ROLE");
				String wDetailRole = rs.getString("W_DETAIL_ROLE");
				
				MatchWantedDTO dto = new MatchWantedDTO(matchWantedIx, wMainRole, wDetailRole);
				
				arr.add(dto);
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
	
	//모임 삭제하는 메소드
	public int recuritDel(int matchApplyIx,int memberIx, int matchIx, int matchWantedIx) {
		try {
			conn = db.DB.getConn();
			
			String sql="DELETE FROM MATCH_RECRUITED_TB WHERE MATCH_APPLY_IX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, matchApplyIx);
			
			int res=0;
			int cnt = ps.executeUpdate();
			
			if(cnt<0) { 
				System.out.println("삭제가 안됨");
				res=ERROR; //첫번째 delete문 삭제가 이루어지지 않았을 때 -1 리턴;
				
			}else { //첫번째 삭제sql이 수행이 잘 되었으면 2번째 삭제 sql 수행함
				String sql2="DELETE FROM MATCH_APPLY_TB WHERE MEMBER_IX=? AND MATCH_IX=? AND MATCH_WANTED_IX=?";
				ps=conn.prepareStatement(sql2);
				ps.setInt(1, memberIx);
				ps.setInt(2, matchIx);
				ps.setInt(3, matchWantedIx);
				
				res = ps.executeUpdate();
			}
			
			return res;
			
		}catch(Exception e) {
			e.printStackTrace();
			System.out.println("exception");
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
	
}
