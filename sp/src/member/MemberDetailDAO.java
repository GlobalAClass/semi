package member;

import java.sql.*;
import java.util.*;

public class MemberDetailDAO {
	private static final int ERROR = -1;

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MemberDetailDAO() {
		System.out.println("MemberDetailDAO 생성");
	}
	
	//회원 추가정보 DB에 입력.
	public int memberDetailJoin(MemberDetailDTO mddto, int member_ix) {
		try {
			conn = db.DB.getConn();
			String sql = "Insert into Member_Detail_TB values(Member_Detail_TB_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_ix);
			ps.setString(2, mddto.getContact());
			ps.setString(3, mddto.getContactAgreement());
			ps.setString(4, mddto.getKakaoId());
			ps.setString(5, mddto.getKakaoIdAgreement());
			ps.setString(6, mddto.getBirthYear());
			ps.setString(7, mddto.getSido());
			ps.setString(8, mddto.getSigungu());
			ps.setString(9, mddto.getmProfile());

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
