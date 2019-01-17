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
}
