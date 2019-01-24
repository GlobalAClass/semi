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
	
	//매칭에서 구하는 팀원에 대한 내용
	public ArrayList<MatchWantedDTO> MatchAddPeople(Integer matchIx){
		try {
			conn=db.DB.getConn();
			String sql="select * from Match_Wanted_TB where Match_IX=?";
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
	
	
	
	
	
	
	
}
