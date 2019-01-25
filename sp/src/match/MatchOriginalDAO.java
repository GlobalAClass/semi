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
			String sql="select * from Match_Original_TB where Match_IX=?";
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
	
	
	
	
	
}
