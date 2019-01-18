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
	//idEmail 중복 확인
	public boolean checkEmail(String idEmail) {
		try {
			conn = db.DB.getConn();
			String sql = "select 1 from Member_TB where ID_EMAIL = '"+ idEmail+"'";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				//아이디가 이미 DB에 존재
				return true;
			}else {
				//아이디가 DB에 없음
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return true; // error 
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

	// DB에 회원 필수 정보 입력
	public int memberJoin(MemberDTO mdto, int memberSEQ) {
		try {
			System.out.println("memberJoin() 호출");
			conn = db.DB.getConn();
			String sql = "Insert into Member_TB values(?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, memberSEQ);
			ps.setString(2, mdto.getidEmail());
			ps.setString(3, mdto.getPwd());
			ps.setString(4, mdto.getMName());
			ps.setString(5, mdto.getEmailAgreement());
			ps.setString(6, mdto.getFieldMajor());

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
	
	// 회원 인덱스 구하기.
	public int getMemberIndex(String idEmail) {
		try {
			System.out.println(" getMemberIndex(String idEmail) 호출");
			conn = db.DB.getConn();
			String sql = "select MEMBER_IX from Member_TB where ID_EMAIL = '"+idEmail+"'";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			rs.next();
			return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR; // error = -1
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
	
	//회원 테이블의 다음 시퀀스 값 구하기.
	public int getMemberSEQUENCE() {
		try {
			System.out.println("getMemberSEQUENCE()호출");
			conn = db.DB.getConn();
			String sql = "select Member_TB_SEQ.nextval from dual";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			rs.next();
			return rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR; // error = -1
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
