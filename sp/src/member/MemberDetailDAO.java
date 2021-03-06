package member;

import java.sql.*;
import java.util.*;

import org.apache.tomcat.jni.Mmap;

public class MemberDetailDAO {
	private static final int ERROR = -1;

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;

	public MemberDetailDAO() {
		System.out.println("MemberDetailDAO 생성");
	}

	// member_ix로 회원 추가(=상세) 정보 조회
	public MemberDetailDTO getMemberDetailInfo(int member_ix) {
		try {
			conn = db.DB.getConn();
			String sql = "select * from Member_Detail_TB where MEMBER_IX = " + member_ix;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			rs.next();
			MemberDetailDTO mddto = new MemberDetailDTO(rs.getInt("Member_Detail_IX"), rs.getInt("MEMBER_IX"), rs.getString("CONTACT"), 
														rs.getString("CONTACT_AGREEMENT"), rs.getString("KAKAO_ID"), rs.getString("KAKAO_ID_AGREEMENT"), 
														rs.getString("BIRTH_YEAR"), rs.getString("SIDO"), rs.getString("SIGUNGU"), 
														rs.getString("M_PROFILE"), rs.getString("SEARCH_AGREEMENT"));
			return mddto;
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

	// 회원 추가정보 DB에 입력.
	public int memberDetailJoin(MemberDetailDTO mddto, int member_ix) {
		try {
			System.out.println("memberDetailJoin() 호출");
			conn = db.DB.getConn();
			String sql = "Insert into Member_Detail_TB values(Member_Detail_TB_SEQ.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'false')";
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


	// 수정된 정보 DB 업데이트
	public int memberDetailUpdate(MemberDetailDTO mddto, int idx) {
		try {
			conn = db.DB.getConn();
			String sql = "UPDATE MEMBER_DETAIL_TB SET CONTACT=?,CONTACT_AGREEMENT=?,KAKAO_ID=?,KAKAO_ID_AGREEMENT=?,BIRTH_YEAR=?,SIDO=?,SIGUNGU=?,M_PROFILE=?,SEARCH_AGREEMENT=? WHERE MEMBER_IX=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mddto.getContact());
			ps.setString(2, mddto.getContactAgreement());
			ps.setString(3, mddto.getKakaoId());
			ps.setString(4, mddto.getKakaoIdAgreement());
			ps.setString(5, mddto.getBirthYear());
			ps.setString(6, mddto.getSido());
			ps.setString(7, mddto.getSigungu());
			ps.setString(8, mddto.getmProfile());
			ps.setString(9, mddto.getSearchAgreement());
			ps.setInt(10, idx);

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
