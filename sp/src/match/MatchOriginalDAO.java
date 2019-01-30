package match;

import java.sql.*;
import java.util.*;

public class MatchOriginalDAO {

	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MatchOriginalDAO() {
		System.out.println("MatchOriginalDAO 생성");
	}
	
	//모임글 작성시에 현재 함께하고 있는 인원 입력하는 함수
	public int insertOriginalM(MatchOriginalDTO ogdto) {
		try {
			conn = db.DB.getConn();
			String sql = "Insert into Match_Original_TB values(Match_Original_TB_SEQ.nextVal, ?, ?, ?, ?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ogdto.getMatchIx());
			ps.setString(2, ogdto.getogMainRole());
			ps.setString(3, ogdto.getogDetailRole());
			ps.setString(4, ogdto.getmemberNumber());

			int count = ps.executeUpdate();
			return count;

		} catch (Exception e) {
			e.printStackTrace();
			return -1; // error = -1
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
	
	//매칭글 인덱스로 모집 이전 인원 테이블 가져오기.
	public ArrayList<MatchOriginalDTO> getogMemberInfo(Integer matchIx){
		try {
			conn=db.DB.getConn();
			String sql="select * from Match_Original_TB where Match_IX=? order by match_original_ix";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, matchIx);
			rs=ps.executeQuery();
			ArrayList<MatchOriginalDTO> arr=new ArrayList<MatchOriginalDTO>();
			while(rs.next()) {
				// 매칭 멤버 테이블 인덱스
				Integer matchOriginalIx=rs.getInt("Match_Original_IX");
				// 담당 역할-대분류
				String ogMainRole=rs.getString("OG_MAIN_ROLE");
				// 담당 역할-소분류
				String ogDetailRole=rs.getString("OG_DETAIL_ROLE");
				// 함께하고 있는 멤버 수
				String memberNumber=rs.getString("MEMBER_NUMBER");
				MatchOriginalDTO dto=new MatchOriginalDTO(matchOriginalIx, matchIx, ogMainRole, ogDetailRole, memberNumber);
				arr.add(dto);
			}
			return arr;
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
	
	//DB에 있는 index 가져오기.
	public ArrayList<Integer> getOriginalIndices(int matchIx){
		try {
			conn=db.DB.getConn();
			String sql="select Match_Original_IX from Match_Original_TB where Match_IX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, matchIx);
			rs=ps.executeQuery();
			ArrayList<Integer> arr=new ArrayList<Integer>();
			while(rs.next()) {
				// 매칭 멤버 테이블 인덱스
				Integer matchOriginalIx=rs.getInt("Match_Original_IX");
				arr.add(matchOriginalIx);
			}
			return arr;
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
	
	//Match_Original_IX로 delete
	public int delOriginalMember(int matchOriginalIx) {
		try {
			conn = db.DB.getConn();
			String sql = "DELETE FROM Match_Original_TB WHERE Match_Original_IX = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, matchOriginalIx);
			int count = ps.executeUpdate();

			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1; 
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
	
	//DB에 일치하는 index를 확인(_OK에서 처리)한 dto만 update
	public int modifyOriginalMember(MatchOriginalDTO ogdto) {
		try {
			conn = db.DB.getConn();
			String sql = "UPDATE Match_Original_TB SET OG_MAIN_ROLE = ?, OG_DETAIL_ROLE = ?, MEMBER_NUMBER = ? WHERE Match_Original_IX = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, ogdto.getogMainRole());
			ps.setString(2, ogdto.getogDetailRole());
			ps.setString(3, ogdto.getmemberNumber());
			ps.setInt(4, ogdto.getMatchOriginalIx());
			int count = ps.executeUpdate();

			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return -1; 
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
