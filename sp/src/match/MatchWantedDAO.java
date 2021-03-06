package match;

import java.sql.*;
import java.util.*;

public class MatchWantedDAO {
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public MatchWantedDAO() {
		System.out.println("MatchWantedDAO 생성");
	}
	
	// 모임글 작성시에 구하는 인원 입력하는 함수
	public int insertWantedM(MatchWantedDTO wdto) {
		try {
			conn = db.DB.getConn();
			String sql = "Insert into Match_Wanted_TB values(Match_Wanted_TB_SEQ.nextVal, ?, ?, ?, ?, ?, ?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, wdto.getMatchIx());
			ps.setString(2, wdto.getwMainRole());
			ps.setString(3, wdto.getwDetailRole());
			ps.setString(4, wdto.getRequiredAbility());
			ps.setString(5, wdto.getWantedNumber());
			ps.setString(6, wdto.getRecruitedNumber());

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
	
	//매칭에서 구하는 팀원에 대한 내용 / index 메인페이지 최근올라온 모임5개 목록보기 DAO
	public ArrayList<MatchWantedDTO> MatchAddPeople(Integer matchIx){
		try {
			conn=db.DB.getConn();
			String sql="select * from Match_Wanted_TB where Match_IX=? order by match_wanted_ix";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, matchIx);
			rs=ps.executeQuery();
			ArrayList<MatchWantedDTO> arr=new ArrayList<MatchWantedDTO>();
			while(rs.next()) {
				// 매칭 멤버 테이블 인덱스
				Integer matchWantedIx=rs.getInt("Match_Wanted_IX");
				// 담당 역할-대분류
				String wMainRole=rs.getString("W_MAIN_ROLE");
				// 담당 역할-소분류
				String wDetailRole=rs.getString("W_DETAIL_ROLE");
				// 필요 능력사항
				String requiredAbility=rs.getString("REQUIRED_ABILITY");
				// 필요 인원 수
				String wantedNumber=rs.getString("WANTED_NUMBER");
				// 해당 역할 모집된 인원 수
				String recruitedNumber=rs.getString("RECRUITED_NUMBER");
				MatchWantedDTO dto=new MatchWantedDTO(matchWantedIx, matchIx, wMainRole, wDetailRole, requiredAbility, wantedNumber, recruitedNumber);
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
	public ArrayList<Integer> getWantedIndices(int matchIx){
		try {
			conn=db.DB.getConn();
			String sql="select Match_Wanted_IX from Match_Wanted_TB where Match_IX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, matchIx);
			rs=ps.executeQuery();
			ArrayList<Integer> arr=new ArrayList<Integer>();
			while(rs.next()) {
				// 매칭 멤버 테이블 인덱스
				Integer matchWantedIx=rs.getInt("Match_Wanted_IX");
				arr.add(matchWantedIx);
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
	
	//Match_Wanted_IX로 delete
	public int delWantedMember(int matchWantedIx) {
		try {
			conn = db.DB.getConn();
			String sql = "DELETE FROM Match_Wanted_TB WHERE Match_Wanted_IX = ?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, matchWantedIx);
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
	//recruited_number 0으로 줌.
	public int modifyWantedMember(MatchWantedDTO wdto) {
		try {
			conn = db.DB.getConn();
			String sql = "UPDATE Match_Wanted_TB SET W_MAIN_ROLE = ?, W_DETAIL_ROLE = ?, REQUIRED_ABILITY = ?, WANTED_NUMBER = ?, RECRUITED_NUMBER = 0 WHERE Match_Wanted_IX = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, wdto.getwMainRole());
			ps.setString(2, wdto.getwDetailRole());
			ps.setString(3, wdto.getRequiredAbility());
			ps.setString(4, wdto.getWantedNumber());
			ps.setInt(5, wdto.getmatchWantedIx());
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