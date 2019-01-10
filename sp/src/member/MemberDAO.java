package member;

import java.sql.*;
import java.util.*;

public class MemberDAO {
	
	private static final int ERROR = -1;
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	// 기본 생성자.
	public MemberDAO() {
		System.out.println("MemeberDAO 생성");
	}
	
	// 회원 필수 정보 입력
	public int JoinMember(MemberDTO mdto) {
		try {
			conn = db.DB.getConn();
			String sql = "Insert into Member_TB values(Member_TB_SEQ.nextval, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mdto.getidEmail());
			ps.setString(2, mdto.getPwd());
			ps.setString(3, mdto.getMName());
			ps.setString(4, mdto.getEmailAgreement());
			ps.setString(5, mdto.getFieldMajor());
			
			int count = ps.executeUpdate();
			return count;
			
		}catch(Exception e){
			e.printStackTrace();
			return ERROR; // error = -1
		}finally {
			try {
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2){
				
			}
		}
	}
	
	

}
