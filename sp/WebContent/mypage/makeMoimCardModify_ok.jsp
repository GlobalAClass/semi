<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="member.*" %>
<%@ page import="competition.*"%>
<%@ page import="match.*"%>
<% request.setCharacterEncoding("UTF-8");	 %>

<jsp:useBean id="memberdao" class="member.MemberDAO"/>

<jsp:useBean id="matdao" class="match.MatchDAO"/>
<jsp:useBean id="matdto" class="match.MatchDTO"/>
<jsp:setProperty property="*" name="matdto"/>

<jsp:useBean id="ogdao" class="match.MatchOriginalDAO"/>
<jsp:useBean id="ogdto" class="match.MatchOriginalDTO"/>

<jsp:useBean id="wdao" class="match.MatchWantedDAO"/>
<jsp:useBean id="wdto" class="match.MatchWantedDTO"/>


<%
	/*
	수정 절차.
	0. 수정페이지에서 정보 가져오기.
	1. DB에 존재하는 index가 있는지 확인.
	2. DB에 존재하지만 넘겨받은 index가 없을 경우, delete
	3. 있으면 update
	4. 없으면 insert
	*/
	
/*
//모임글 수정 확인용 코드
out.print(matdto.getMemberIx()+"/");
out.print(matdto.getCompetitionInfoIx()+"/");
out.print(matdto.getMatchName()+"/");
out.print(matdto.getMainRole()+"/");
out.print(matdto.getDetailRole()+"/");
out.print(matdto.getOriginalMemberNumber()+"/");
out.print(matdto.getSido()+"/");
out.print(matdto.getSigungu()+"/");
out.print(matdto.getTimesAWeek()+"/");
out.print(matdto.getDay()+"/");
out.print(matdto.getTotalWantedNumber()+"/");
out.print(matdto.getAgeRestriction()+"/");
out.print(matdto.getEquipTech()+"/");
out.print(matdto.getDetail()+"/");
out.print(matdto.getCompletedState()+"/");
out.print(matdto.getWriteDate()+"<br>");
//모임글에 구하는 인원들 확인용 코드
int tcnt = Integer.parseInt(request.getParameter("cnt"));
if(tcnt>0){
	String originalIX_str[] = request.getParameterValues("matchOriginalIX");
	String ogMainRoles[] = request.getParameterValues("ogMainRole");
	String ogDetialRole[] = request.getParameterValues("ogDetailRole");
	String memberNumber[] = request.getParameterValues("memberNumber");
	
	for(int i =0; i<tcnt; i++){
		out.print("현재 구성된"+i+"번째 역할 : ");
		out.print(originalIX_str[i]+"/");
		out.print(ogMainRoles[i]+"/");
		out.print(ogDetialRole[i]+"/");
		out.print(memberNumber[i]+"<br>");
	}
}
//모임글에 구하는 인원들 확인용 코드
int twcnt = Integer.parseInt(request.getParameter("wcnt"));
if(twcnt>0){
	String wantedIX_str[] = request.getParameterValues("matchWantedIX");
	String wMainRoles[] = request.getParameterValues("wMainRole");
	String wDetialRole[] = request.getParameterValues("wDetailRole");
	String ra[] = request.getParameterValues("requiredAbility");
	String wn[] = request.getParameterValues("wantedNumber");
	String rcn[] = request.getParameterValues("recruitedNumber");
	for(int i =0; i<twcnt; i++){
		out.print("원하는"+i+"번째 역할 : ");
		out.print(wantedIX_str[i]+"/");
		out.print(wMainRoles[i]+"/");
		out.print(wDetialRole[i]+"/");
		out.print(ra[i]+"/");
		out.print(wn[i]+"/");
		out.print(rcn[i]+"<br>");
	}
}
*/
%>

<%

//공모전은 수정사항 업데이트만 하면 됨.
	int checkm = matdao.modifyMoimCard(matdto);

//공모전 인덱스 구하기
	int matchIx =matdto.getMatchIx();

//현재 있는, 구하는 인원 수 확인하기 위한 변수.
	int cnt = Integer.parseInt(request.getParameter("cnt"));
	int wcnt = Integer.parseInt(request.getParameter("wcnt"));

	//오류 확인을 위한 배열
	int checkogup[] = new int[cnt];
	int checkogin[] = new int[cnt];
	int checkogdel[] = new int[cnt];
	int checkwup[] = new int[wcnt];
	int checkwin[] = new int[wcnt];
	int checkwdel[] = new int[wcnt];

	//모임글에 현재 같이 진행중인 인원들
	if(cnt>0){
		String originalIX_str[] = request.getParameterValues("matchOriginalIX");
		String ogMainRoles[] = request.getParameterValues("ogMainRole");
		String ogDetialRole[] = request.getParameterValues("ogDetailRole");
		String memberNumber[] = request.getParameterValues("memberNumber");
		
		//originalIX_str을 integer로 변환
		ArrayList<Integer> originalIX = new ArrayList<Integer>();
		for(int i=0; i<originalIX_str.length; i++){
			if(originalIX_str[i].equals("") || originalIX_str[i] ==null){
				originalIX.add(-1);
			}else{
				originalIX.add(Integer.parseInt(originalIX_str[i]));
			}
		}
		
		//DB에 존재하는 Match_Original_IX 구하기
		ArrayList<Integer> ogix = ogdao.getOriginalIndices(matchIx);
		
		//DB에는 존재하지만 이전 페이지에서 받은 IX에 존재하지 않는 값 찾기 -> delete할 값
		for(int i=0; i< ogix.size(); i++){
			boolean del = true;
			for(int j=0; j<originalIX.size(); j++){
				if(ogix.get(i).equals(originalIX.get(j))){
					del = false;
					break;
				}
			}
			//해당 인덱스를 이용해 DB에서 삭제 후, DB에 존재하는 ix 리스트에서도 삭제.
			if(del){
				checkogdel[i] = ogdao.delOriginalMember(ogix.get(i));
				ogix.remove(i);
				System.out.println("인덱스가 "+i+"인  original DB삭제");
				i--;
			}
		}
		
		//페이지에서 받은 IX와 DB에 존재하는 IX일치하는 값 찾기. -> update할 값
		for(int i=0; i< cnt; i++){
			boolean isinsert = true;
			//DB애 존재하는 Ix만 update하기
			for(int j=0; j<ogix.size(); j++){
				if(originalIX.get(i).equals(ogix.get(j))){
				ogdto = new MatchOriginalDTO(originalIX.get(i), matchIx, ogMainRoles[i], ogDetialRole[i], memberNumber[i]);
				checkogup[i] = ogdao.modifyOriginalMember(ogdto);
				isinsert = false;
				break;
				}
			}
			//DB에 존재하지 않는 Ix는 insert하기
			if(isinsert){
			ogdto = new MatchOriginalDTO(matchIx, ogMainRoles[i], ogDetialRole[i], memberNumber[i]);
			checkogin[i] = ogdao.insertOriginalM(ogdto);
			System.out.println("인덱스가 "+i+"인  original 역할 추가");
			}
		}
		
	}
		

	//모임글에 구하는 인원들 
	if(wcnt>0){
		String wantedIX_str[] = request.getParameterValues("matchWantedIX");
		String wMainRoles[] = request.getParameterValues("wMainRole");
		String wDetialRole[] = request.getParameterValues("wDetailRole");
		String ra[] = request.getParameterValues("requiredAbility");
		String wn[] = request.getParameterValues("wantedNumber");
		String rcn[] = request.getParameterValues("recruitedNumber");
		
		//wantedIX_str을 integer로 변환
		ArrayList<Integer> wantedIX = new ArrayList<Integer>();
		for (int i = 0; i < wantedIX_str.length; i++) {
			if(wantedIX_str[i].equals("") || wantedIX_str[i] ==null){
				wantedIX.add(-1);
			}else{
				wantedIX.add(Integer.parseInt(wantedIX_str[i]));
			}
		}

		//DB에 존재하는 Match_wanted_IX 구하기
		ArrayList<Integer> wix = wdao.getWantedIndices(matchIx);

		//DB에는 존재하지만 이전 페이지에서 받은 IX에 존재하지 않는 값 찾기 -> delete할 값
		for (int i = 0; i < wix.size(); i++) {
			boolean del = true;
			for (int j = 0; j < wantedIX.size(); j++) {
				if (wix.get(i).equals(wantedIX.get(j))) {
					del = false;
					break;
				}
			}
			//해당 인덱스를 이용해 DB에서 삭제 후, DB에 존재하는 ix 리스트에서도 삭제.
			if (del) {
				checkwdel[i] = wdao.delWantedMember(wix.get(i));
				wix.remove(i);
				i--;
			}
		}

		//페이지에서 받은 IX와 DB에 존재하는 IX일치하는 값 찾기. -> update할 값
		for (int i = 0; i < wcnt; i++) {
			boolean isinsert = true;
			//DB애 존재하는 Ix만 update하기
			for (int j = 0; j < wix.size(); j++) {
				if (wantedIX.get(i).equals(wix.get(j))) {
					wdto = new MatchWantedDTO(wantedIX.get(i), matchIx, wMainRoles[i], wDetialRole[i], ra[i], wn[i], rcn[i]);
					checkwup[i] = wdao.modifyWantedMember(wdto);
					isinsert = false;
					break;
				}
			}
			//DB에 존재하지 않는 Ix는 insert하기
			if (isinsert) {
				wdto = new MatchWantedDTO(matchIx, wMainRoles[i], wDetialRole[i], ra[i], wn[i], rcn[i]);
				checkwin[i] = wdao.insertWantedM(wdto);
			}
		}

	}

	String msg ="";
	if(checkm<0){
		msg="모임 정보 수정 오류\n";
	}
	else{
		for(int i =0; i<cnt; i++){
			if(checkogdel[i] <0){
				msg += i+1+"번째 함께하고 있는 인원 삭제 오류\n";
			}
		}
		for(int i =0; i<cnt; i++){
			if(checkogup[i] <0){
				msg += i+1+"번째 함께하고 있는 인원 수정 오류\n";
			}
		}
		for(int i =0; i<cnt; i++){
			if(checkogin[i] <0){
				msg += i+1+"번째 함께하고 있는 인원 입력 오류\n";
			}
		}
		for(int i =0; i<wcnt; i++){
			if(checkwdel[i] <0){
				msg += i+1+"번째 함께하고 있는 인원 삭제 오류\n";
			}
		}
		for(int i =0; i<wcnt; i++){
			if(checkwup[i] <0){
				msg += i+1+"번째 함께하고 있는 인원 수정 오류\n";
			}
		}
		for(int i =0; i<wcnt; i++){
			if(checkwin[i] <0){
				msg += i+1+"번째 함께하고 있는 인원 입력 오류\n";
			}
		}
	}
	
	if(msg.equals("")){
		%><script>
			alert('수정되었습니다.');
			location.href='/sp/mypage/makeMoim.jsp';
		</script><%
	}else{
		%><script>
			alert('<%=msg%>');
			location.href='/index.jsp';
		</script><%
	}
%>



