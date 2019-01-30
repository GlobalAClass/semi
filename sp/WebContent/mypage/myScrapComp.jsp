<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="competition.*"%>
<%@ page import="member.*" %>


<%

//본인 인덱스 가져오는 메소드
String crt_id = (String)session.getAttribute("sidEmail");
MemberDAO dao = new MemberDAO();
int member_ix=dao.getMemberIndex(crt_id);

CompetitionScrapDAO scdao = new CompetitionScrapDAO();

//공모전 목록보기 페이징
int totalcnt=scdao.getTotalCnt();
int listsize=10;
int pagesize=10;
String cp_s=request.getParameter("cp");

if(cp_s==null||cp_s.equals("")){
	cp_s="1";
}
int cp=Integer.parseInt(cp_s);

int totalpage=totalcnt/listsize+1;
if(totalcnt%listsize==0){
	totalpage--;
}
int usergroup=cp/pagesize;
if(cp%pagesize==0){
	usergroup--;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/sp/css/mainLayout.css">
</head>
<style>
article{
	width:800px;
	margin-left:100px;
}
#main{
	width:800px;
	height:auto;
}
#main thead th{
	background: #424242;
	color:white;
	border-top: 0.5px solid black;
	border-bottom: 0.5px solid black;
	border-spacing:0px;
}
h1{
	font-size: 30px;
	text-align: center;
	margin: 0px;
	padding: 9px;
}
tbody a{
	text-decoration:none;
	cursor: pointer;
	color: black;
	font-weight: bold;
}
tbody a:hover{
	background: #BDBDBD;
	font-weight: bold;
}
tfoot a{
	text-decoration: none;
	color:#58ACFA;
}
</style>
<body>
<%@include file="/header.jsp" %>
<%@include file="/mypage/aside.jsp" %>
<section>
<article>
<div align="center" style="font-size:40px;font-weight:bold;margin:20px;">내가 스크랩한 공모전 목록</div>
<div id="main" align="center">
	<table style="width:800px;" border="1" cellspacing="0">
		<thead>
			<tr>
				<th>분류</th>
				<th>제목</th>
				<th>접수기간</th>
				<th>팀/개인</th>
				<th>조회수</th>
			</tr>
		</thead>
		<tbody>
		<%
		ArrayList<CompetitionInfoDTO> arr= scdao.myScrapComp(cp, listsize, member_ix);
		if(arr==null||arr.size()==0){
			%>
			<tr>
				<td colspan="5"><h2>스크랩한 공모전이 없습니다.</h2></td>
			</tr>
			<%
		}else{
			for(int i=0;i<arr.size();i++){
				%>
				<tr>
					<td><%=arr.get(i).getField()%></td>
					<td style="width:300px;"><a href="/sp/Competition/CompetitionDetail.jsp?ix=<%=arr.get(i).getCompetitionInfoIx()%>"><%=arr.get(i).getCName()%></a></td>
					<td style="width:200px;"><%=arr.get(i).getPeriod()%></td>
					<td><%=arr.get(i).getTeamSolo()%></td>
					<td><%=arr.get(i).getReadnum()%></td>
				</tr>
				<%
			}
		}
		%>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="5" align="center">
				<%
				if(usergroup!=0){
					%>
					<a href="Competition.jsp?cp=<%=(usergroup-1)*pagesize+pagesize%>">&lt;&lt;</a>
					<%
				}
				%>
				<%
				for(int i=usergroup*pagesize+1;i<usergroup*pagesize+pagesize;i++){
					%>
					&nbsp;&nbsp;<a href="Competition.jsp?cp=<%=i%>"><%=i%></a>&nbsp;&nbsp;
					<%
					if(i==totalpage)break;
				}
				%>
				<%
				if(usergroup!=(totalpage/pagesize-(totalpage%pagesize==0?1:0))){
					%>
					<a href="Competition.jsp?cp=<%=(usergroup+1)*pagesize+1%>">&gt;&gt;</a>
					<%
				}
				%>
				</td>
			</tr>
		</tfoot>
	</table>
</div>
</article>
</section>
<%@include file="/footer.jsp" %>
</body>
</html>