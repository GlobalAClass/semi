package hsearch;

import java.sql.*;
import java.util.*;

import hsearch.*;
import member.MemberDTO;
import member.MemberDetailDTO;


public class HsearchDAO {
	
	private static final int ERROR = -1;

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public HsearchDAO() {
		System.out.println("HumanSearchDAO 생성");
	}
	
	//request로 부터 온 값이 null인지 체크하는 함수
	public boolean isNull(String str) {
		if(str ==null || str.equals("") || str.equals("undefiend"))
			return true;
		else
			return false;
	}
	//Pair클래스 따로 정의해둠. hsearch패키지안에 있음.
	public Pair<MemberDTO, MemberDetailDTO> Pair(MemberDTO mdto, MemberDetailDTO mddto) {
		Pair<MemberDTO, MemberDetailDTO> pair = new Pair<MemberDTO, MemberDetailDTO>(mdto, mddto);
		return pair;
	}
	//조건에 맞는 사람을 검색하는 함수 //회원 정보 보여줄때도 활용가능.
	public ArrayList<Pair<MemberDTO, MemberDetailDTO>> searchHuman(String sido, String sigungu, String fieldMajor) {
		try {
			conn=db.DB.getConn();
			
			//+SEARCH_AGREEMENT = 'TRUE' 추가해야함 테스트를 위해 빼고 진행
			String sql = "SELECT * FROM MEMBER_TB M, MEMBER_DETAIL_TB MD WHERE M.MEMBER_IX = MD.MEMBER_IX";
			if(!isNull(fieldMajor)) {
				sql += " AND FIELD_MAJOR LIKE '%"+fieldMajor+"%'";
			}
			if(!isNull(sido)) {
				sql += " AND SIDO ='"+sido+"'";
				if(!isNull(sigungu)) {
					sql += " AND SIGUNGU ='"+sigungu+"'";
				}
			}
			sql += " ORDER BY M.MEMBER_IX DESC";
			
			System.out.println(sql);
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			
			ArrayList<Pair<MemberDTO, MemberDetailDTO>>  searchlist = new ArrayList<Pair<MemberDTO, MemberDetailDTO>>();
			if(rs.next()) {
				do {
				int member_ix = rs.getInt("MEMBER_IX");
				String idEmail=rs.getString("ID_EMAIL");
				String pwd=rs.getString("PWD");
				String mName=rs.getString("M_NAME");
				String emailAgreement=rs.getString("EMAIL_AGREEMENT");
				String fieldMajor_=rs.getString("FIELD_MAJOR");
				
				String contact = rs.getString("CONTACT");
				String contactAgreement = rs.getString("CONTACT_AGREEMENT");
				String kakaoId = rs.getString("KAKAO_ID");
				String kakaoIdAgreement = rs.getString("KAKAO_ID_AGREEMENT");
				String birthYear = rs.getString("BIRTH_YEAR");
				String sido_ = rs.getString("SIDO");
				String sigungu_ = rs.getString("SIGUNGU");
				String mProfile = rs.getString("M_PROFILE");
				String searchAgreement = rs.getString("SEARCH_AGREEMENT");
				
				MemberDTO mdto = new MemberDTO(member_ix, idEmail, pwd, mName, emailAgreement, fieldMajor_);
				MemberDetailDTO mddto = new MemberDetailDTO(contact, contactAgreement, kakaoId, kakaoIdAgreement, birthYear, sido_, sigungu_, mProfile, searchAgreement);
				searchlist.add(Pair(mdto, mddto));
				}while(rs.next());
			}
			return searchlist;
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