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
	
	public Pair<MemberDTO, MemberDetailDTO> Pair(MemberDTO mdto, MemberDetailDTO mddto) {
		Pair<MemberDTO, MemberDetailDTO> pair = new Pair<MemberDTO, MemberDetailDTO>(mdto, mddto);
		return pair;
	}
	
	//회원이 스크랩한 사람의 카드에 넣을 조건을 가져오는 메소드
	public ArrayList<Pair<MemberDTO,MemberDetailDTO>> myScrapHumanCard(int member_ix) {
		try {
			conn=db.DB.getConn();
			
			String sql="select h.scrap_member_ix, m.m_name , md.birth_year, m.field_major, md.sido, md.sigungu, m.id_email " + 
					"from human_scrap_Tb h, member_tb m, member_detail_tb md " + 
					"where h.member_ix=? and (m.member_ix=h.scrap_member_ix) and m.member_ix=md.member_ix";
			
			ps=conn.prepareStatement(sql);
			ps.setInt(1, member_ix);
			
			rs = ps.executeQuery();
			
			ArrayList<Pair<MemberDTO,MemberDetailDTO>> myScrapCards = new ArrayList<Pair<MemberDTO,MemberDetailDTO>>();
			
			if(rs.next()) {
				do {
					int scrapMemberIx = rs.getInt("SCRAP_MEMBER_IX");
					String idEmail = rs.getString("ID_EMAIL");
					String mName = rs.getString("M_NAME");
					String fieldMajor = rs.getString("FIELD_MAJOR");
					String birthYear = rs.getString("BIRTH_YEAR");
					String sido = rs.getString("SIDO");
					String sigungu	= rs.getString("SIGUNGU");
					
					MemberDTO dto = new MemberDTO(scrapMemberIx,idEmail,mName,fieldMajor);
					MemberDetailDTO ddto = new MemberDetailDTO(birthYear, sido, sigungu);
					
					myScrapCards.add(Pair(dto,ddto));
					
				}while(rs.next());
			}
			
			return myScrapCards;
			
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				
			}catch(Exception e2) {}
		}
	}
}
