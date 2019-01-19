<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.nio.charset.Charset"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="db.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="member.*" %>

<%
		//request.setCharacterEncoding("UTF-8"); //post 전송때, 한글깨짐 막기위해 세팅. - 서버에 get방식은 설정되어있음. --MultipartRequest때문에 사용안함.
	//회원 필수 정보 DAO
	MemberDAO mdao = new MemberDAO();
	//경로 설정을 하기 위해 회원 인덱스를 가져와야함.
	int member_ix = mdao.getMemberSEQUENCE();
	//경로 설정 -- 회원넘버를 폴더명으로 하는 폴더 생성할 경로.
	String path = request.getServletContext().getRealPath("\\")+ "\\img\\profile\\"+member_ix;
	//회원 폴더 생성 -- 이미지를 선택했든 안했든 폴더를 만듦.
	File img_folder = new File(path);
	boolean a = img_folder.mkdir();
	
	try{
		//회원 프로필 업로드
		int sizeLimit = 5*1024*1024; //프로필 사진 크기는 5MB로 제한.
		MultipartRequest mr = new MultipartRequest(request, path, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		//회원 필수 정보 DTO
		MemberDTO mdto = new MemberDTO(mr.getParameter("idEmail"), mr.getParameter("pwd"), mr.getParameter("MName"), 
										mr.getParameter("emailAgreement"),mr.getParameter("fieldMajor"));
		//회원 추가 정보 DTO
		MemberDetailDTO mddto = new MemberDetailDTO(mr.getParameter("contact"),mr.getParameter("contactAgreement"),mr.getParameter("kakaoId"),
													mr.getParameter("kakaoIdAgreement"), mr.getParameter("birthYear"),mr.getParameter("sido"),
													mr.getParameter("sigungu"), mr.getParameter("mProfile"));
		//회원 추가 정보 DAO
		MemberDetailDAO mddao = new MemberDetailDAO();
		
		//공모전 데이터들
		int addCount = Integer.parseInt(mr.getParameter("addCount")); //공모전 이력 개수.
		//공모전 이력 담을 ArrayList
		ArrayList<MemberHistoryDTO> mhdto = new ArrayList<MemberHistoryDTO>();
		//공모전 상세이력 받기.
		for(int i = 0;i<addCount; i++){
			String cName = mr.getParameter("cName"+i);
			String period = mr.getParameter("period"+i);
			String mainRole = mr.getParameter("mainRole"+i);
			String detailRole = mr.getParameter("detailRole"+i);
			String award = mr.getParameter("award"+i);
			String detail = mr.getParameter("detail"+i);
			mhdto.add(new MemberHistoryDTO(cName, period, mainRole, detailRole, award, detail));
		}
		//회원 필수 정보 입력
		String msg1 = mdao.memberJoin(mdto, member_ix)<0? "필수 정보 입력 오류" : "";
		//회원 추가 정보 입력
		String msg2 = mddao.memberDetailJoin(mddto, member_ix)<0? "추가 정보 입력 오류": "";
		//회원 공모전 정보 입력
		String msg3 = "";
		MemberHistoryDAO mhdao = new MemberHistoryDAO();
		for(int i = 0;i<addCount; i++){
			int num = mhdao.memberHistoryJoin(mhdto.get(i), member_ix);
			if(num<0) msg3 += "공모전 정보 입력 오류: "+i+"번째 상세 이력 저장 오류\n";
		}
		//오류 출력
		if(!msg1.equals("")){
			%><script>alert('<%=msg1%>');</script><%
		} else if(!msg2.equals("")){
			%><script>alert('<%=msg2%>');</script><%
		} else if(!msg3.equals("")){
			%><script>alert('<%=msg3%>');</script><%
		}
	}catch(Exception e){
		out.print(e);
			%><script>alert('프로필 이미지 업로드시 문제 발생');</script><%
	}
%>

<script>
location.href="/sp/index.jsp";
</script>

