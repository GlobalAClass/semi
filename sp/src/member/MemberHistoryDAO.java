package member;

import java.sql.*;
import java.util.*;

public class MemberHistoryDAO {
	
	private static final int ERROR = -1;

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MemberHistoryDAO() {
		System.out.println("MemberHIstoryDAO 생성");
	}
	
	// member_ix로 회원 공모전이력  조회
	public ArrayList<MemberHistoryDTO> getMemberHistoryInfo(int member_ix) {
		try {
			conn = db.DB.getConn();
			String sql = "select * from Member_History_TB where MEMBER_IX = " + member_ix;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			ArrayList<MemberHistoryDTO> list = new ArrayList<MemberHistoryDTO>();
			if (rs.next()) {
				do {
					MemberHistoryDTO mhdto = new MemberHistoryDTO(rs.getInt(1), rs.getInt(2), rs.getString(3),
																  rs.getString(4), rs.getString(5), rs.getString(6),
																  rs.getString(7), rs.getString(8));
					list.add(mhdto);
				}while(rs.next());
			}
			return list;
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

	public int memberHistoryJoin(MemberHistoryDTO mhdto, int member_ix) {
		try {
			System.out.println("memberHistoryDTO() 호출");
			conn = db.DB.getConn();
			String sql = "Insert into Member_History_TB values(Member_History_TB_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_ix);
			ps.setString(2, mhdto.getCName());
			ps.setString(3, mhdto.getPeriod());
			ps.setString(4, mhdto.getMainRole());
			ps.setString(5, mhdto.getDetailRole());
			ps.setString(6, mhdto.getAward());
			ps.setString(7, mhdto.getDetail());

			int count = ps.executeUpdate();
			return count;

		} catch (Exception e) {
			e.printStackTrace();
			return ERROR; // error = -1
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
	
	
	//각 개인별 공모전 이력 출력하기 위해 사용하는 메소드
	public ArrayList<MemberHistoryDTO> myProfileHistoryInfo(int idx) {
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT * FROM MEMBER_HISTORY_TB WHERE MEMBER_IX=? ORDER BY MEMBER_HISTORY_IX ASC";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			
			rs=ps.executeQuery();
			
			ArrayList<MemberHistoryDTO> arr=new ArrayList<MemberHistoryDTO>();
			
			if(rs.next()) {
				do {
					Integer memberHistoryIx = rs.getInt("MEMBER_HISTORY_IX");
					Integer memberIx = rs.getInt("MEMBER_IX");
					String cName=rs.getString("C_NAME");
					String period=rs.getString("PERIOD");
					String mainRole=rs.getString("MAIN_ROLE");
					String detailRole=rs.getString("DETAIL_ROLE");
					String award=rs.getString("AWARD");
					String detail=rs.getString("DETAIL");
					
					MemberHistoryDTO dto=new MemberHistoryDTO(memberHistoryIx, memberIx, cName, period, mainRole, detailRole, award, detail);
					arr.add(dto);
				}while(rs.next());
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
	
	//myProfile_ok 2. 삭제 구현
	//현재 db에 존재하는 idx 추출하는 메소드
	public int[] getAllidx(int idx) {
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT MEMBER_HISTORY_IX from member_history_tb WHERE MEMBER_IX=? ORDER BY MEMBER_HISTORY_IX";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			
			rs=ps.executeQuery();
			
			Vector<Integer> v = new Vector<Integer>();
			if(rs.next()) {
				do{
					int index=rs.getInt("MEMBER_HISTORY_IX");
					v.add(index);
				}while(rs.next());
			}
			
			int dbIndex[]=new int[v.size()];
			
			for(int i=0;i<dbIndex.length;i++) {
				dbIndex[i]=v.get(i);
			}
			
			return dbIndex;
		
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e) {}
		}
	}
	
	//삭제 내역 idx 전송 해주는 메소드
	public void myProfileHistoryDelete(int idx, int[] idxs) {
		//현재 db에 존재하는 idx 가져오고
		int dbIdx[] = getAllidx(idx);
		
		//delete 해야할 idx값 vector에 넣기 (db전체 idx에서 update idx 제외한 값)
		Vector<Integer> v =	new Vector<Integer>();
		
		for(int i=0;i<dbIdx.length;i++) {
			boolean flag=true;
			for(int j=0;j<idxs.length;j++) {
				if(dbIdx[i]==idxs[j])
					flag=false;
			}
			if(flag) {
				v.add(dbIdx[i]);
			}
		}
		
		for(int i=0;i<v.size();i++) {
			deleteIdx(v.get(i));
		}
	}
	
	//공모전 상세내역 삭제하는 메소드
	public int deleteIdx(int idx) {
		
		try {
			conn=db.DB.getConn();
			
			String sql="DELETE FROM MEMBER_HISTORY_TB WHERE MEMBER_HISTORY_IX=?";
			
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			
			int count = ps.executeUpdate();
			return count;
			
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e) {}
		}
	}
	
	
	//공모전 상세내역 수정하는 메소드
	public int myProfileHistoryUpdate(int hidx,int idx, MemberHistoryDTO mhdto) {
		try {
			conn=db.DB.getConn();
			
			String sql="UPDATE Member_History_TB " + 
					"SET " + 
					"C_NAME=?," + 
					"PERIOD=?," + 
					"MAIN_ROLE=?," + 
					"DETAIL_ROLE=?," + 
					"AWARD=?," + 
					"DETAIL=? " + 
					"WHERE MEMBER_HISTORY_IX=? AND MEMBER_IX=?";
			
			ps=conn.prepareStatement(sql);
			ps.setString(1, mhdto.getCName());
			ps.setString(2, mhdto.getPeriod());
			ps.setString(3, mhdto.getMainRole());
			ps.setString(4, mhdto.getDetailRole());
			ps.setString(5, mhdto.getAward());
			ps.setString(6, mhdto.getDetail());
			ps.setInt(7, hidx);
			ps.setInt(8, idx);
			
			int count = ps.executeUpdate();
			return count;
			
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e) {}
		}
	}
	
}
