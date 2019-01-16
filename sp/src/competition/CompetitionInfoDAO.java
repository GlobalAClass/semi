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
	public ArrayList<CompetitionInfoDTO> CompetitionAllList(int cp,int list){
		try {
			conn=db.DB.getConn();
			//페이징을 위한 sql 수정
			//String sql="select * from Competition_Info_TB order by Competition_Info_IX desc";
			String sql="select * from " +
					"(select rownum as rnum,a.* from " + 
					"(select * from Competition_Info_TB order by Competition_Info_IX desc)a)b " + 
					"where rnum>=(("+cp+"-1)*"+list+"+1) and rnum<="+cp+"*"+list;
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			ArrayList<CompetitionInfoDTO> arr=new ArrayList<CompetitionInfoDTO>();
			while(rs.next()) {
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
	//페이징 위한 총게시물수 관련
	public int getTotalCnt(){
		try {
			conn=db.DB.getConn();
			String sql="select count(*) from Competition_Info_TB";
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			rs.next();
			int count=rs.getInt(1);
			return count==0?1:count;
		}catch(Exception e){
			e.printStackTrace();
			return 1;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2) {}
		}
	}
}






















