<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.regex.*" %> <!-- 정규식 사용을 위해 import -->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분야/전공 찾기</title>
</head>
<style>
form ul li input{
	border: none;
	cursor: pointer;
}
form ul li input:hover{
	background: #E9F0FD;
	font-weight: bold;
}
</style>
<%
	String str_search = request.getParameter("search");
	ArrayList<String> list = new ArrayList<String>();
	
	if(str_search != null && !str_search.equals("")){
		try{
			//경로 설정 -request.getSession().getServletContext().getRealPath("/")가 해당 프로젝트 폴더까지 즉 sp까지임.
			String path = request.getSession().getServletContext().getRealPath("/")+ "\\text\\fieldMajor.txt";
			//파일 객체 생성
			File file = new File(path);
			//입력 스트림 생성 - 인코딩이 디폴트값으로 되어 글자가 깨져서 주석처리.
				//FileReader fr = new FileReader(file);
			//입력 버퍼 생성
				//BufferedReader br = new BufferedReader(fr); //한글깨져서 주석처리
			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file),"euc-kr"));
			
			//찾을 패턴 만들기.
				// (?i) <- "찾을 문자열"에 대소문자 구분을 없애고
    			// .*   <- 문자열이 행의 어디에 있든지 찾을 수 있게
    		String findStr = "(?i).*" + str_search + ".*";
			
			//패턴과 일치하는 것만 list에 추가.
			String major = "";
			while((major = br.readLine()) != null){
				if(major.matches(findStr)){
					list.add(major);
				}
			}
		
		}catch(Exception e){
			e.printStackTrace();
		}
	}
%>
<script>
//검색버튼 눌렀을 때
function searchFieldMajor(){
	var str_search = document.feildMajor.search.value;
	location.href='fieldMajorPop.jsp?search='+str_search;
}
//분야/전공 선택했을 때
function selectFieldMajor(obj){
	opener.document.memberJoin.fieldMajor.value=obj.value;
    window.self.close();
}
</script>
<body>
	<form name=feildMajor>
	분야/전공 검색:<input type="text" name="search"><input type="button" value="검색" onclick="searchFieldMajor()">
	<ul>
		<%
		Iterator<String> i = list.iterator();
		while(i.hasNext()){
			%>
			<li><input type="text" onclick="selectFieldMajor(this)" value="<%=i.next()%>" ></li>
			<% 
		}
		%>
	</ul>
	</form>
</body>
</html>