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
	
	// member_ix로 회원 정보 조회
	public MemberDTO getMemberInfo(int member_ix) {
		try {
			conn = db.DB.getConn();
			String sql = "select * from Member_TB where MEMBER_IX = " + member_ix;
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			rs.next();
			MemberDTO mdto = new MemberDTO(rs.getInt("MEMBER_IX"),rs.getString("ID_EMAIL"),rs.getString("PWD"),
											rs.getString("M_NAME"),rs.getString("EMAIL_AGREEMENT"),rs.getString("FIELD_MAJOR"));
			return mdto;
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

	// idEmail 중복 확인
	public boolean checkEmail(String idEmail) {
		try {
			conn = db.DB.getConn();
			String sql = "select 1 from Member_TB where ID_EMAIL = '" + idEmail + "'";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			if (rs.next()) {
				// 아이디가 이미 DB에 존재
				return true;
			} else {
				// 아이디가 DB에 없음
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
			String sql = "select MEMBER_IX from Member_TB where ID_EMAIL = '" + idEmail + "'";
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

	// 회원 테이블의 다음 시퀀스 값 구하기.
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

	// 로그인
	public boolean ChceckidEmailPwd(String idEmail, String pwd) {
		try {
			conn = db.DB.getConn();

			String sql = "select pwd from Member_TB where ID_EMAIL=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, idEmail);
			rs = ps.executeQuery();
			if (rs.next()) {
				String dbpwd = rs.getString("pwd");
				if (dbpwd.equals(pwd)) {
					return true;
				} else {
					return false;
				}

			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return false;
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

	public String getMemberName(String idEmail) {
		try {
			conn = db.DB.getConn();
			String sql = "select m_name from Member_TB where ID_EMAIL=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, idEmail);
			rs = ps.executeQuery();

			if (rs.next()) {
				return rs.getString("M_NAME");
			} else {
				return null;
			}
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
	
	public String getMemberName(int member_ix) {
		try {
			conn = db.DB.getConn();
			String sql = "select m_name from Member_TB where MEMBER_IX=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_ix);
			rs = ps.executeQuery();

			if (rs.next()) {
				return rs.getString("M_NAME");
			} else {
				return null;
			}
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

	//idx에 따라 기본 정보 넘겨 받기 위한 메소드 - myProfile 사용
	public MemberDTO myProfileInfo(int idx) {
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT * FROM MEMBER_TB WHERE MEMBER_IX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, idx);
			
			rs=ps.executeQuery();
			
			MemberDTO dtos=null;
			if(rs.next()) {
				String idEmail=rs.getString("ID_EMAIL");
				String pwd=rs.getString("PWD");
				String mName=rs.getString("M_NAME");
				String emailAgreement=rs.getString("EMAIL_AGREEMENT");
				String fieldMajor=rs.getString("FIELD_MAJOR");
				
				dtos=new MemberDTO(idEmail, pwd, mName, emailAgreement, fieldMajor);
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
	
	//기본정보 수정하는 메소드
	// DB에 회원 필수 정보 입력
	public int memberUpdate(String fm,String ea, int idx) {
		try {
			conn = db.DB.getConn();
			String sql = "UPDATE MEMBER_TB SET FIELD_MAJOR=?,EMAIL_AGREEMENT=? WHERE MEMBER_IX=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, fm);
			ps.setString(2, ea);
			ps.setInt(3, idx);

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
	
	//index.jsp 메인페이지 최근등록된 사람 5명
	public ArrayList<MemberDTO> RecentPeople(){
		try {
			conn=db.DB.getConn();
			String sql="select * from (select * from Member_TB order by MEMBER_IX desc) where rownum<=5";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<MemberDTO> arr=new ArrayList<MemberDTO>();
			while(rs.next()) {
				//회원 인덱스
				Integer memberIx=rs.getInt("MEMBER_IX");
				//회원 아이디
				String idEmail=rs.getString("ID_EMAIL");
				//비밀번호
				String pwd=rs.getString("PWD");
				//회원 이름
				String mName=rs.getString("M_NAME");
				//이메일수신동의
				String emailAgreement=rs.getString("EMAIL_AGREEMENT");
				//회원 분야/전공
				String fieldMajor=rs.getString("FIELD_MAJOR");
				MemberDTO dto=new MemberDTO(memberIx, idEmail, pwd, mName, emailAgreement, fieldMajor);
				arr.add(dto);
			}
			return arr;
		}catch(Exception e){
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
	
	
	public boolean areYouRecruitedMember(int match_ix, int match_wanted_ix, int member_ix){
		try {
			conn=db.DB.getConn();
			String sql="select MEMBER_IX from Match_Recruited_TB where Match_IX = "+match_ix+" and Match_Wanted_IX = "+match_wanted_ix;
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			
			while(rs.next()) {
				//회원 인덱스
				Integer memberIx=rs.getInt("MEMBER_IX");
				if(member_ix == memberIx) {
					return true;
				}
			}
			return false;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
	
	public ArrayList<String> getRecruitedMemberName(int match_ix, int match_wanted_ix){
		try {
			conn=db.DB.getConn();
			String sql="select MEMBER_IX from Match_Recruited_TB where Match_IX = "+match_ix+" and Match_Wanted_IX = "+match_wanted_ix;
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			
			ArrayList<String> name_list = new ArrayList<String>();
			if(rs.next()) {
				do {
				//회원 인덱스
				Integer memberIx=rs.getInt("MEMBER_IX");
				name_list.add(getMemberName(memberIx));
				}while(rs.next());
			}
			return name_list;
		}catch(Exception e){
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
