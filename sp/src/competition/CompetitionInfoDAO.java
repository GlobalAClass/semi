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
				//공모전 정보 인덱스
				Integer competitionInfoIx=rs.getInt("Competition_Info_IX");
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
				CompetitionInfoDTO dto=new CompetitionInfoDTO(competitionInfoIx, CName, field, teamSolo, period, readnum);
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
	
	//공모전 분야별 목록보기
	public ArrayList<CompetitionInfoDTO> CompetitionFieldList(String fields,int cp,int list){
		try {
			conn=db.DB.getConn();
			//String sql="select * from Competition_Info_TB where FIELD=?";
			String sql="select * from" + 
					"(select rownum as rnum,a.* from" + 
					"(select * from Competition_Info_TB where FIELD=?)a)b " + 
					"where rnum>=(("+cp+"-1)*"+list+"+1) and rnum<="+cp+"*"+list;
			ps=conn.prepareStatement(sql);
			ps.setString(1,fields);
			rs=ps.executeQuery();
			ArrayList<CompetitionInfoDTO> arr=new ArrayList<CompetitionInfoDTO>();
			while(rs.next()) {
				//공모전 정보 인덱스
				Integer competitionInfoIx=rs.getInt("Competition_Info_IX");
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
				CompetitionInfoDTO dtos=new CompetitionInfoDTO(competitionInfoIx, CName, field, teamSolo, period, readnum);
				arr.add(dtos);
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
	
	// 공모전 제목 클릭시 정보보기
	public CompetitionInfoDTO CompetitionCNameInfo(Integer ix){
		try {
			conn=db.DB.getConn();
			setReadnum(ix);
			String sql="select * from Competition_Info_TB where Competition_Info_IX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, ix);
			rs=ps.executeQuery();
			CompetitionInfoDTO dtos=null;
			if(rs.next()) {
				//공모전 제목
				String CName=rs.getString("C_NAME");
				//분야
				String field=rs.getString("FIELD");
				//팀/개인
				String teamSolo=rs.getString("TEAM_SOLO");
				//주최
				String auspice=rs.getString("AUSPICE");
				//주관
				String CManage=rs.getString("C_MANAGE");
				//참가자격
				String  entitlement=rs.getString("ENTITLEMENT");
				//접수기간
				String period=rs.getString("PERIOD");
				//홈페이지 링크
				String CLink=rs.getString("C_LINK");
				//공모전 상세 내역
				String detail=rs.getString("DETAIL");
				//공모전 조회수
				Integer  readnum=rs.getInt("READNUM");
				dtos=new CompetitionInfoDTO(ix, CName, field, teamSolo, auspice, CManage, entitlement, period, CLink, detail, readnum);
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
	
	//조회수 관련
	public void setReadnum(Integer ix) {
		try {
			String sql="update Competition_Info_TB set READNUM=READNUM+1 where Competition_Info_IX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1,ix);
			ps.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null)ps.close();
			}catch(Exception e2) {}
		}
	}
	
	//전체 공모전 목록보기 페이징
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
	
	//분야별 공모전 목록보기 페이징
	public int getTotalCnt2(String fields){
		try {
			conn=db.DB.getConn();
			String sql="select count(*) from Competition_Info_TB where FIELD=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, fields);
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


