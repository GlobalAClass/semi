package competition;

import java.sql.*;
import java.util.*;

public class CompetitionInfoDAO{
	
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public CompetitionInfoDAO() {
		System.out.println("CompetitionInfoDAO 생성");
	}
	
	//전체 공모전 목록보기
	public ArrayList<CompetitionInfoDTO> CompetitionAllList(){
		try {
			conn=db.DB.getConn();
			String sql="select * from Competition_Info_TB order by Competition_Info_IX desc";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<CompetitionInfoDTO> arr=new ArrayList<CompetitionInfoDTO>();
			while(rs.next()) {
				System.out.println("반복문");
				//공모전 제목
				String CName=rs.getString("C_NAME");
				//분야
				String field=rs.getString("FIELD");
				//팀/개인
				String teamSolo=rs.getString("TEAM_SOLO");
				//접수기간
				String period=rs.getString("PERIOD");
				//공모전 조회수
				Integer readnum=rs.getInt("READNUM");
				CompetitionInfoDTO dto=new CompetitionInfoDTO(CName,field,teamSolo,period,readnum);
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
