<%@page import="member.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<jsp:useBean id="dao" class="member.MemberDAO"/>
<%
String idEmail = (String)session.getAttribute("sidEmail");
int index = dao.getMemberIndex(idEmail);

//수정된 이미지 들어갈 경로 설정
String path = request.getServletContext().getRealPath("\\")+ "\\img\\profile\\"+index;

//수정된 사진 업로드
try{
	int sizeLimit = 5*1024*1024; //프로필 사진 크기는 5MB로 제한.
	MultipartRequest mr = new MultipartRequest(request, path, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
	
	//수정은 전공/분야 와 이메일 수신여부만 수정 가능함
	String fm=mr.getParameter("fieldMajor");
	String ea=mr.getParameter("emailAgreement");
	
	//추가 정보는 모든 정보 수정 가능함
	MemberDetailDTO ddto = new MemberDetailDTO(mr.getParameter("contact"),mr.getParameter("contactAgreement"),mr.getParameter("kakaoId"),
			mr.getParameter("kakaoIdAgreement"), mr.getParameter("birthYear"),mr.getParameter("sido"),
			mr.getParameter("sigungu"), mr.getParameter("mProfile"),mr.getParameter("searchAgreement"));
	
	//회원 추가 정보 DAO
	MemberDetailDAO ddao = new MemberDetailDAO();
	
	//회원 필수정보 수정
	int res = dao.memberUpdate(fm,ea,index);
	String msg1 = res<0?"필수 정보 수정 오류":"";
	
	//회원 선택정보 수정
	int res2 = ddao.memberDetailUpdate(ddto, index);
	String msg2 = res2<0?"추가 정보 수정 오류":"";
	
	//회원 공모전 세부사항 정보 수정
	
	MemberHistoryDAO hdao = new MemberHistoryDAO();
	int addCount = Integer.parseInt(mr.getParameter("addCount"));
	int crtCompSize = Integer.parseInt(mr.getParameter("crtCompSize"));
	
	//1. db 내부 확인해서 넘어온 idx 이용하여 update하기
	
	int length = Integer.parseInt(mr.getParameter("uIdxlength")); //update되는 값이 몇개인지 계산해오는 파라미터
	
	int updateIdxs[]=new int[length];
	
	ArrayList<MemberHistoryDTO> mhdto = new ArrayList<MemberHistoryDTO>();
	

	//value 가져오는 메소드가 1개일 때와 2개 이상일 때 달라서 구분함
	for(int i=0;i<length;i++){
		if(length==1){
			updateIdxs[i]=Integer.parseInt(mr.getParameter("updateIdx"));
			
			String cName = mr.getParameter("cName");
			String period = mr.getParameter("period");
			String mainRole = mr.getParameter("mainRole");
			String detailRole = mr.getParameter("detailRole");
			String award = mr.getParameter("award");
			String detail = mr.getParameter("detail");
			mhdto.add(new MemberHistoryDTO(cName, period, mainRole, detailRole, award, detail));
		}else{
			String updateIdxs_s[] = mr.getParameterValues("updateIdx");
			//String 배열을 int 배열로 변환
			for(int j=0;j<updateIdxs.length;j++)
				updateIdxs[j]=Integer.parseInt(updateIdxs_s[j]);

			String cName[] = mr.getParameterValues("cName");
			String period[] = mr.getParameterValues("period");
			String mainRole[] = mr.getParameterValues("mainRole");
			String detailRole[] = mr.getParameterValues("detailRole");
			String award[] = mr.getParameterValues("award");
			String detail[] = mr.getParameterValues("detail");
			mhdto.add(new MemberHistoryDTO(cName[i], period[i], mainRole[i], detailRole[i], award[i], detail[i]));
		}
	}
	
	for(int i=0;i<length;i++){
		int res3 = hdao.myProfileHistoryUpdate(updateIdxs[i],index, mhdto.get(i));
	}

	//2. db에는 존재하지만 idx가 존재하지 않는 나머지는 delete하기
		hdao.myProfileHistoryDelete(index,updateIdxs);
	
	
	//3. insert 되는 상세이력 구하기
	ArrayList<MemberHistoryDTO> hdto = new ArrayList<MemberHistoryDTO>();
	
	for(int i=crtCompSize;i<addCount;i++){
		if(addCount-crtCompSize==1){
			String cName = mr.getParameter("cNameUpdate");
			String period = mr.getParameter("periodUpdate");
			String mainRole = mr.getParameter("mainRoleUpdate");
			String detailRole = mr.getParameter("detailRoleUpdate");
			String award = mr.getParameter("awardUpdate");
			String detail = mr.getParameter("detailUpdate");
			hdto.add(new MemberHistoryDTO(cName, period, mainRole, detailRole, award, detail));
		}else{
			String cName[] = mr.getParameterValues("cNameUpdate");
			String period[] = mr.getParameterValues("periodUpdate");
			String mainRole[] = mr.getParameterValues("mainRoleUpdate");
			String detailRole[] = mr.getParameterValues("detailRoleUpdate");
			String award[] = mr.getParameterValues("awardUpdate");
			String detail[] = mr.getParameterValues("detailUpdate");
			hdto.add(new MemberHistoryDTO(cName[i], period[i], mainRole[i], detailRole[i], award[i], detail[i]));
		}
	}
	
	String msg3="";
	
	for(int i=crtCompSize;i<addCount;i++){
		int res5 = hdao.memberHistoryJoin(hdto.get(i), index);
		if(res5<0) msg3 += "공모전 정보 입력 오류: "+i+"번째 상세 이력 저장 오류\n";
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
	%> <script>
	alert('프로필 이미지 수정 시 문제 발생');
	location.href="/sp/mypage/myProfile.jsp";
	</script>
	<%
}

%>
<script>
alert('프로필이 수정되었습니다.');
location.href="/sp/mypage/myProfile.jsp";
</script>