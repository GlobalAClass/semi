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
			System.out.println("memberDetailJoin() 호출");
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
	
	//myProfile에서 자신의 프로필 정보 넘겨 받기 위한 메소드
	public MemberDetailDTO myProfileDetailInfo(int idx) {
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT * FROM MEMBER_DETAIL_TB WHERE MEMBER_IX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			
			rs=ps.executeQuery();
			
			MemberDetailDTO dtos=null;
			if(rs.next()) {
				String contact=rs.getString("CONTACT");
				String contactAgreement=rs.getString("CONTACT_AGREEMENT");
				String kakaoId=rs.getString("KAKAO_ID");
				String kakaoIdAgreement=rs.getString("KAKAO_ID_AGREEMENT");
				String birthYear=rs.getString("BIRTH_YEAR");
				String sido=rs.getString("SIDO");
				String sigungu=rs.getString("SIGUNGU");
				String mProfile=rs.getString("M_PROFILE");
				
				dtos=new MemberDetailDTO(contact, contactAgreement, kakaoId, kakaoIdAgreement, birthYear, sido, sigungu, mProfile);
			}
			return dtos;
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
