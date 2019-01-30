package match;

import java.sql.*;

public class MatchRecruitedDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MatchRecruitedDAO() {
	}
	
	//뽑힌 인원에 대한 정보 테이블에 insert 하는 메소드
	public int applyPick(int match_ix,int match_wanted_ix,int match_apply_ix,int member_ix) {
		try {
			conn=db.DB.getConn();
			
			String sql="INSERT INTO MATCH_RECRUITED_TB VALUES(Match_Recruited_TB_SEQ.NEXTVAL,?,?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, match_ix);
			ps.setInt(2, match_wanted_ix);
			ps.setInt(3, match_apply_ix);
			ps.setInt(4, member_ix);
			
			int cnt = ps.executeUpdate();
			
			return cnt;
			
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			}catch(Exception e2) {}
		}
	}
	
	//insert 후 original 테이블에 해당하는 명 수 증가시켜주는 메소드
	public int originUpdate(int match_wanted_ix) {
		try {
			conn=db.DB.getConn();
			
			String sql="UPDATE MATCH_WANTED_TB SET RECRUITED_NUMBER=RECRUITED_NUMBER+1 WHERE MATCH_WANTED_IX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, match_wanted_ix);
			
			int cnt = ps.executeUpdate();
			
			return cnt;
			
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			}catch(Exception e2) {}
		}
	}
	
	//insert 후 apply 테이블의 hold true값으로 변환해주는 메소드
	public int applyHoldChange(int match_apply_ix) {
		try {
			conn=db.DB.getConn();
			
			String sql="UPDATE MATCH_APPLY_TB SET HOLD='true' WHERE MATCH_APPLY_IX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, match_apply_ix);
			
			int cnt = ps.executeUpdate();
			
			return cnt;
			
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}finally {
			try {
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
			}catch(Exception e2) {}
		}
	}
	
	//모임 삭제하는 메소드
	public int applyDeleteAll(int match_ix) {
		try {
			conn=db.DB.getConn();
			
			String sql="delete from match_recruited_tb where match_ix=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, match_ix);
			
			int cnt=0;
			
			if(ps.executeUpdate()>=0) {
				sql="delete from match_apply_tb where match_ix=?";
				ps=conn.prepareStatement(sql);
				ps.setInt(1, match_ix);
				
				if(ps.executeUpdate()>=0) {
					sql="delete from match_wanted_tb where match_ix=?";
					ps=conn.prepareStatement(sql);
					ps.setInt(1, match_ix);
					
					if(ps.executeUpdate()>=0) {
						sql="delete from match_original_tb where match_ix=?";
						ps=conn.prepareStatement(sql);
						ps.setInt(1, match_ix);
						
						if(ps.executeUpdate()>=0) {
							sql="delete from match_tb where match_ix=?";
							ps=conn.prepareStatement(sql);
							ps.setInt(1, match_ix);
							cnt = ps.executeUpdate();
						}
					}
				}
			}
			
			return cnt;
			
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
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
