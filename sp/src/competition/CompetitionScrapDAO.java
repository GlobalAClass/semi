package competition;

import java.sql.*;
import java.util.*;

public class CompetitionScrapDAO {
	private static final int ERROR = -1;
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	public CompetitionScrapDAO() {
	}
	
	//회원이 스크랩 했는지 안했는지 판별하는 메소드
	public boolean checkScrapComp(int member_ix,int scrap_comp_ix) {
		try {
			conn = db.DB.getConn();
			
			String sql = "SELECT 1 FROM COMPETITION_SCRAP_TB WHERE MEMBER_IX=? AND COMPETITION_INFO_IX=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, member_ix);
			ps.setInt(2, scrap_comp_ix);
			
			rs=ps.executeQuery();
			
			if(rs.next()) {
				return true;
			}else {
				return false;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}finally {
			try {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();	
			}catch(Exception e2) {}
		}
	}
	
	//스크랩 추가하는 메소드
	public int insertScrapComp(int member_ix, int scrap_comp_ix) {
		try {
			conn = db.DB.getConn();
			String sql = "INSERT INTO COMPETITION_SCRAP_TB VALUES(Competition_Scrap_TB_SEQ.NEXTVAL,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_ix);
			ps.setInt(2, scrap_comp_ix);

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
	//스크랩 삭제하는 메소드
	public int deleteScrapComp(int member_ix, int scrap_comp_ix) {
		try {
			conn = db.DB.getConn();
			String sql = "DELETE FROM COMPETITION_SCRAP_TB WHERE MEMBER_IX=? AND COMPETITION_INFO_IX=?";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, member_ix);
			ps.setInt(2, scrap_comp_ix);
			
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
	
	//페이징 하기 위해 공모전 목록 갯수 구하는 메소드
	public int getTotalCnt(){
		try {
			conn=db.DB.getConn();
			String sql="SELECT COUNT(*) FROM COMPETITION_SCRAP_TB";
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
	
	//스크랩된 공모전 정보 가져오는 메소드
	public ArrayList<CompetitionInfoDTO> myScrapComp(int cp,int listSize,int member_ix){
		try {
			conn=db.DB.getConn();
			
			String sql="SELECT * FROM (SELECT ROWNUM AS RNUM,A.* FROM (SELECT CS.COMPETITION_SCRAP_IX,CI.* FROM COMPETITION_INFO_TB CI,COMPETITION_SCRAP_TB CS WHERE CS.MEMBER_IX="+member_ix+" AND CS.COMPETITION_INFO_IX=CI.COMPETITION_INFO_IX ORDER BY COMPETITION_SCRAP_IX DESC)A)B WHERE RNUM>=((1-1)*10+1) AND RNUM<=1*10";
			
			ps=conn.prepareStatement(sql);
			rs=ps.executeQuery();
			
			ArrayList<CompetitionInfoDTO> myScrapComps = new ArrayList<CompetitionInfoDTO>();
			
			while(rs.next()) {;
				
					//공모전 정보 인덱스
					Integer competitionScrapIx=rs.getInt("COMPETITION_SCRAP_IX");
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
					//공모전 이미지 파일명
					String CImage=rs.getString("C_IMAGE");
					
					CompetitionInfoDTO dto = new CompetitionInfoDTO(competitionScrapIx, CName, field, teamSolo, period, readnum, CImage);
				
					myScrapComps.add(dto);
					
			}
			System.out.println(myScrapComps.size());
			return myScrapComps;
			
		}catch(Exception e) {
			e.printStackTrace();
			return null;
		}finally {
			try {
				if(rs!=null)rs.close();
				if(ps!=null)ps.close();
				if(conn!=null)conn.close();
			}catch(Exception e2){}
		}
	}
	
}
