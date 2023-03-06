<%@page import="persist.*"%>
<%@page import="javax.ws.rs.*" %>
<%@page import="java.util.*" %>
<%@page import="javax.ws.rs.client.*" %>
<%@page import="javax.ws.rs.client.Invocation.*" %>
<%@page import="javax.ws.rs.core.*" %>
<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.PersistenceContext"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="services.Question"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

 <% String userid = request.getParameter("user"); 
 	
 	int u = Integer.parseInt(userid);
    EntityManagerFactory emf = Persistence.createEntityManagerFactory("vaalikones");
	EntityManager em = emf.createEntityManager();
 	Ehdokkaat user = em.find(Ehdokkaat.class, u); 
 	Question question = new Question(user);
 	List<Kysymykset> all = question.All();
 	%>

 	<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="candidatescript.js"></script>
<link href="style.css" rel="stylesheet" type="text/css">
<title>Questions</title>
</head>
<body>

 <img id="headerimg" src="Logo.png" width="720" /><br><br>
  <div class="kysymys"><small>0=Neutraali 1=Täysin eri mieltä 2=Osittain eri mieltä <br>3=En osaa sanoa, 4=Osittain samaa mieltä 5=Täysin samaa mieltä</small></div>
<div class="container">

	<% 
	for (Kysymykset one : all) {
		// Getting single answer for question. will always return an answer.
		Vastaukset ans = question.Answer(one); 
		System.out.println(ans);
		
		int selected = ans.getVastaus();
		int questnum = one.getKysymysId();
		
		
		String name = "vastaus" + one.getKysymysId().toString();
		
		ObjectMapper mapper = new ObjectMapper();
		//Converts vastausks to json string and stores it to html elements..data-json
		String json = mapper.writeValueAsString(ans);
	%>

	<p class="ans"><%=questnum%>:
		<%=one.getKysymys()%></p>



	<form id="" action="#" method="POST" onsubmit='return false;'>
		<%
		 int nums = 5;
		 for( int i =0; i<6; i++){
			 String check = "";
			 if(i==selected){
				 check = " checked='checked'";
			 }
			%>
		
		<label><%=i %></label><input type="radio" name="vastaus"
			value="<%=i %>" <%=check%> />


		<%
		 }
		 
		 %>
		<input type="hidden" name="qId" value="<%=questnum %>" /> <input
			type="hidden" name="old" value="<%=selected %>" /> <input
			type="hidden" name="uId" value="<%=user.getEhdokasId() %>" /> <input
			type="button" name="submit" value="Save Answer"
			onclick="sendAns(this.form);" />
	</form>
	<% 
	}
	%>
</div><br>


</body>
</html>