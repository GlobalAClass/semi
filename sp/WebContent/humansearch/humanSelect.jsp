<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="member.*" %>
<%@ page import="match.*" %>
<%@ page import="java.io.File" %>

<jsp:useBean id="madto" class="match.MatchApplyDTO"></jsp:useBean>
<jsp:setProperty property="*" name="madto"/>
<jsp:useBean id="mdao" class="member.MemberDAO"></jsp:useBean>
<jsp:useBean id="mddao" class="member.MemberDetailDAO"></jsp:useBean>
<jsp:useBean id="mhdao" class="member.MemberHistoryDAO"></jsp:useBean>

<%!
	//
	public String manageNull(String str) {
		if (str == null || str.equals("")) {
			return "";
		} else {
			return str;
		}
	}
%>


<%
	//madto.setMemberIx(79); //test용도로 사용한 코드줄. 공모전 이력있는 회원인덱스 번호를 주면 테스트할 수 있음.
	//구현안 된 내용. 
	//1. 자기소개, 2. 현재또는 다른 공모전 여부, 3. submit할 때 폼(폼형태는 아래에 기술 되어 있음)에 입력될 값 넣기.-모임글인덱스, 신청글 인덱스. 
	
	request.setCharacterEncoding("UTF-8");	

	//신청한 사람의 회원 인덱스 구하기
	String member_ix_s=request.getParameter("member_ix");
	if(member_ix_s==null||member_ix_s.equals("")){
		member_ix_s="0";
	}
	int member_ix=Integer.parseInt(member_ix_s);
	//회원 인덱스로 회원 이미지 추가하기
	File proimg=new File(request.getServletContext().getRealPath("\\")+"\\img\\profile\\"+member_ix);
	File[] files=proimg.listFiles();
	String imgpath;
	if(files.length>0){
		imgpath="/sp/img/profile/"+member_ix+"/"+files[0].getName();
	}else{
		imgpath="/sp/img/profile_default.jpg";
	}
	//회원인덱스로 회원의 필수사항, 추가사항 받기
	MemberDTO mdto = mdao.getMemberInfo(member_ix);
	MemberDetailDTO mddto = mddao.getMemberDetailInfo(member_ix);
	//회원인덱스로 회원의 공모전 이력 받기
	ArrayList<MemberHistoryDTO> list = mhdao.getMemberHistoryInfo(member_ix);
	int len = 0;
	if(list!=null){
		len = list.size();
	}
	
	//출력할 값 중 null값이 있는지 확인.
	String birthyear = manageNull(mddto.getBirthYear());
	String sido = manageNull(mddto.getSido());
	String sigungu = manageNull(mddto.getSigungu());
	String kakaoid = manageNull(mddto.getKakaoId());
	String contact = manageNull(mddto.getContact());
	
	//KAKAOID, CONTACT 공개여부 확인
	if(mddto.getKakaoIdAgreement().equals("false")){
		kakaoid = "비공개";
	}
	if(mddto.getContactAgreement().equals("false")){
		contact= "비공개";
	}
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
<style>
body{
	font-family: Arial;
}
#top_table {
	margin: 50px auto;
	width: 800px;
	height: 200px;
	padding: 2px;
	border-collapse: collapse;
	border-spacing: 0;
	border: none;
	font-size: 20px;
	text-align: justify;
}
#top_table tr{
	height: 60px;
}
#top_table td{
	width: 180px;
	height: 60px;
}
#m_pfofile{
	text-align: center;
}
.fontsize_35{
	font-size: 35px;
}
input{
	width : 100px;
	height : 40px;
	font-size: 20px;
}
article {
	text-align: center;
}
</style>
</head>
<script>
</script>
<body>
	<%@include file="/header.jsp"%>
	<section>
		<article>
			<table id="top_table">
				<tr>
					<td rowspan="4" style="width: 140px"><img src="<%=imgpath%>"
						style="width: 100px; height: 120px; padding: 2px;"></td>
					<td style="width: 200px; font-weight: bold; font-size: 40px"><%=mdto.getMName() %></td>
					<td style="width: 200px; font-size: 20px; color: gray;"><%=birthyear %></td>
					<td align="left" style="width: 200px; font-weight: bold"><%=mdto.getFieldMajor() %></td>
				</tr>
				<tr>
					<td colspan="2"><img src="/sp/img/location.png"
						style="width: 40px; height: 40px; padding-right: 5px;"><%=sido %> <%=sigungu %></td>
					<td></td>

				</tr>
				<tr>
					<td><img src="/sp/img/mail.png"
						style="width: 30px; height: 20px; padding-right: 5px;"><%=mdto.getidEmail() %></td>
					<td><img src="/sp/img/talk.png"
						style="width: 50px; height: 40px; padding-right: 5px;"><%=kakaoid %></td>
					<td><img src="/sp/img/phone.jpg"
						style="width: 45px; height: 35px; padding-right: 5px;"><%=contact %></td>
				</tr>
				<tr>
					<td colspan="3">공모전 경력 <span><%if(len>0){out.print("있음");}else{out.print("없음");} %></span></td>
				</tr>
			</table>
			
			<%
			for(int i=0; i<len; i++){
				String mainrole = manageNull(list.get(i).getMainRole());
				String detailrole = manageNull(list.get(i).getDetailRole());
				String award = manageNull(list.get(i).getAward());
				String detail = manageNull(list.get(i).getDetail());
			%>
			<jsp:include page="humanSelectDetail.jsp" flush="false">
				<jsp:param value="<%=list.get(i).getCName() %>" name="cName"/>
				<jsp:param value="<%=list.get(i).getPeriod() %>" name="period"/>
				<jsp:param value="<%=mainrole %>" name="mainRole"/>
				<jsp:param value="<%=detailrole %>" name="detailRole"/>
				<jsp:param value="<%=award %>" name="award"/>
				<jsp:param value="<%=detail %>" name="detail"/>
			</jsp:include>
			<%
			}
			%>
			
			<div id="m_pfofile">
				<h3 class="fontsize_35">자기소개</h3>
				<p><pre style="margin: 0px auto;font-size: 20px; width: 700px;"><%=mddto.getmProfile() %></pre></p>
			</div>
			</article>
	</section>
	<%@include file="/footer.jsp"%>
</body>
</html>