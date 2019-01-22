package hsearch;

import java.sql.*;
import java.util.*;

import member.MemberDTO;
import member.MemberDetailDTO;


public class HumanScrapDAO {
	private static final int ERROR = -1;

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public HumanScrapDAO() {
		System.out.println("HumanScrapDAO 생성");
	}
	
	//스크랩한 인원 추가.
	public int scrapHuman(int member_ix, int scrap_member_ix) {
		try {
			conn = db.DB.getConn();
			String sql = "Insert into Human_Scrap_TB values(Human_Scrap_TB_SEQ.nextval, ?, ?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_ix);
			ps.setInt(2, scrap_member_ix);

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
	
	//스크랩한 인원 제거
	public int delScrapHuman(int member_ix, int scrap_member_ix) {
		try {
			conn = db.DB.getConn();
			String sql = "DELETE FROM Human_Scrap_TB WHERE MEMBER_IX = '"+member_ix+"' AND SCRAP_MEMBER_IX = '"+scrap_member_ix+"'";
			ps = conn.prepareStatement(sql);

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
	
	//회원의 스크랩한 인원이 맞는지 판단하는 함수.
	public boolean checkScrapHuman(int member_ix, int scrap_member_ix) {
		try {
			conn = db.DB.getConn();
			String sql = "select 1 from Human_Scrap_TB where MEMBER_IX = '" + member_ix + "' AND SCRAP_MEMBER_IX = '"+scrap_member_ix+"'";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if (rs.next()) {
				return true;
			}else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false; // error
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
}
