<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="match.*" %>
<% request.setCharacterEncoding("UTF-8");	 %>

<jsp:useBean id="matchdto" class="match.MatchDTO"/>
<jsp:setProperty property="*" name="matchdto"/>
<jsp:useBean id="matchdao" class="match.MatchDAO"/>

<jsp:useBean id="ogdto" class="match.MatchOriginalDTO"/>
<jsp:useBean id="ogdao" class="match.MatchOriginalDAO"/>

<jsp:useBean id="wdto" class="match.MatchWantedDTO"/>
<jsp:useBean id="wdao" class="match.MatchWantedDAO"/>

<%
	/*
	//모임글 확인용 코드
	out.print(matchdto.getMemberIx()+"\n");
	out.print(matchdto.getCompetitionInfoIx()+"\n");
	out.print(matchdto.getMatchName()+"\n");
	out.print(matchdto.getMainRole()+"\n");
	out.print(matchdto.getDetailRole()+"\n");
	out.print(matchdto.getOriginalMemberNumber()+"\n");
	out.print(matchdto.getSido()+"\n");
	out.print(matchdto.getSigungu()+"\n");
	out.print(matchdto.getTimesAWeek()+"\n");
	out.print(matchdto.getDay()+"\n");
	out.print(matchdto.getTotalWantedNumber()+"\n");
	out.print(matchdto.getAgeRestriction()+"\n");
	out.print(matchdto.getEquipTech()+"\n");
	out.print(matchdto.getDetail()+"\n");
	out.print(matchdto.getCompletedState()+"\n");
	out.print(matchdto.getWriteDate()+"<br>");
	//모임글에 구하는 인원들 확인용 코드
	int tcnt = Integer.parseInt(request.getParameter("cnt"));
	if(tcnt>0){
		String ogMainRoles[] = request.getParameterValues("ogMainRole");
		String ogDetialRole[] = request.getParameterValues("ogDetailRole");
		String memberNumber[] = request.getParameterValues("memberNumber");
		
		for(int i =0; i<tcnt; i++){
			out.print(ogMainRoles[i]+"\n");
			out.print(ogDetialRole[i]+"\n");
			out.print(memberNumber[i]+"<br>");
		}
	}
	//모임글에 구하는 인원들 확인용 코드
	int twcnt = Integer.parseInt(request.getParameter("wcnt"));
	if(twcnt>0){
		String wMainRoles[] = request.getParameterValues("wMainRole");
		String wDetialRole[] = request.getParameterValues("wDetailRole");
		String ra[] = request.getParameterValues("requiredAbility");
		String wn[] = request.getParameterValues("wantedNumber");
		String rcn[] = request.getParameterValues("recruitedNumber");
		for(int i =0; i<twcnt; i++){
			out.print(wMainRoles[i]+"\n");
			out.print(wDetialRole[i]+"\n");
			out.print(ra[i]+"\n");
			out.print(wn[i]+"\n");
			out.print(rcn[i]+"<br>");
		}
	}
	*/
	
	
	
	//모임글 DB insert.
	int matchIx = matchdao.getMatchSEQUENCE();
	matchdao.makeMoim(matchdto, matchIx);
	
	//현재 있는, 구하는 인원 수 확인하기 위한 변수.
	int cnt = Integer.parseInt(request.getParameter("cnt"));
	int wcnt = Integer.parseInt(request.getParameter("wcnt"));


	//모임글에 현재 같이 진행중인 인원들 DB insert.
	if(cnt>0){
		String ogMainRoles[] = request.getParameterValues("ogMainRole");
		String ogDetialRole[] = request.getParameterValues("ogDetailRole");
		String memberNumber[] = request.getParameterValues("memberNumber");
		for(int i =0; i<cnt; i++){
			ogdto = new MatchOriginalDTO(matchIx, ogMainRoles[i], ogDetialRole[i], memberNumber[i]);
			ogdao.insertOriginalM(ogdto);
		}
	}

	//모임글에 구하는 인원들 DB insert.
	if(wcnt>0){
		String wMainRoles[] = request.getParameterValues("wMainRole");
		String wDetialRole[] = request.getParameterValues("wDetailRole");
		String ra[] = request.getParameterValues("requiredAbility");
		String wn[] = request.getParameterValues("wantedNumber");
		String rcn[] = request.getParameterValues("recruitedNumber");
		for(int i =0; i<cnt; i++){
			wdto = new MatchWantedDTO(matchIx, wMainRoles[i], wDetialRole[i], ra[i], wn[i], rcn[i]);
			wdao.insertWantedM(wdto);
		}
	}

%>