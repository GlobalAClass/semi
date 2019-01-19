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
			
			String sql="SELECT * FROM MEMBER_HISTORY_TB WHERE MEMBER_IX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			
			rs=ps.executeQuery();
			
			ArrayList<MemberHistoryDTO> arr=new ArrayList<MemberHistoryDTO>();
			while(rs.next()) {
				String cName=rs.getString("C_NAME");
				String period=rs.getString("PERIOD");
				String mainRole=rs.getString("MAIN_ROLE");
				String detailRole=rs.getString("DETAIL_ROLE");
				String award=rs.getString("AWARD");
				String detail=rs.getString("DETAIL");
				
				MemberHistoryDTO dto=new MemberHistoryDTO(cName, period, mainRole, detailRole, award, detail);
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
