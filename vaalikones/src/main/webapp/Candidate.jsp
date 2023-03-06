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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

 <% String user = (String)request.getAttribute("User"); 
 	int u = Integer.parseInt(user);
 	EntityManagerFactory emf = Persistence.createEntityManagerFactory("vaalikones");
	EntityManager em = emf.createEntityManager();
 	Ehdokkaat eh = em.find(Ehdokkaat.class, u);
 %>
 
 <%String uri = "http://127.0.0.1:8080/rest/Questionservices/getAllv";

Client asiakas=ClientBuilder.newClient();
 WebTarget wt=asiakas.target(uri);
 Builder b=wt.request();


 //Create a GenericType to be able to get List of objects
 //This will be the second parameter of post method
 GenericType<List<Vastaukset>> genericList = new GenericType<List<Vastaukset>>() {};
 Entity<String> e=Entity.entity(user,MediaType.APPLICATION_JSON);
	
	

	
 //Getting all the Questions
 List<Vastaukset> returnedList=b.post(e, genericList);
 
 String uriq = "http://127.0.0.1:8080/rest/Questionservices/getAllq";

 Client asiakasq=ClientBuilder.newClient();
  WebTarget wtq=asiakasq.target(uriq);
  Builder bq=wtq.request();


  //Create a GenericType to be able to get List of objects
  //This will be the second parameter of post method
  GenericType<List<Kysymykset>> genericListq = new GenericType<List<Kysymykset>>() {};
  //Entity<String> eq=Entity.entity(user,MediaType.APPLICATION_JSON);
 	
 	

 	
  //Getting all the Questions
  List<Kysymykset> returnedListq=bq.get(genericListq);
  
%>

<!DOCTYPE html>
<html>
<head>

<link href="style.css" rel="stylesheet" type="text/css">

<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body onLoad="getCandidate();">
	<div align="center">
		<p id="name"></p>
		
		<div class="addButton" align="center">
<input class ="EditAnswer" type="button" value= "Edit Answers"
					onclick="window.location='EditAnswers.jsp?user=<%=eh.getEhdokasId()%>'">

</div>
	</div>
	<table>
		<thead>
			<tr>

				<th>Question ID</th>
				<th>Question</th>
				<th>Answer</th>
				
				
			</tr>
		</thead>
		<tbody>
		
		<%
		for(int j = 0; j <returnedListq.size();j++) {
			Kysymykset q = returnedListq.get(j);		
			
			
			out.println("<tr><td>"+ q.getKysymysId() +"</td>");
			out.println("<td>"+ q.getKysymys() +"</td>");
			
			for(int i = 0; i < returnedList.size();i++){

			Vastaukset k = returnedList.get(i);
			
			
			
				
				
			if(k.getVastaus()==null){
				
				String noAnswer = "Not Answered";
				out.println("<td>"+ noAnswer +"</td></tr>");
			}
			else if(q.getKysymysId()==k.getVastauksetPK().getKysymysId()){
			out.println("<td>"+ k.getVastaus() +"</td></tr>");
			}
			
			
			}
			
			
		}
		%>
		
		</tbody>
	</table>
	<script>
	function getCandidate(){
		xmlHttp = new XMLHttpRequest();
		xmlHttp.onreadystatechange = function(){
			if(this.readyState == 4 && this.status == 200) {
	//				document.getElementById("userid").innerHTML=this.responseText;
					var jsUser = JSON.parse(this.responseText);
					document.getElementById("name").innerHTML= "Welcome " + jsUser.etunimi + " " + jsUser.sukunimi;
			}
		}
		xmlHttp.open("POST","/rest/Questionservices/getCandidate",true);
		xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlHttp.send("User=" + <%=user%>);
	}
	
	function getAllv(){
		xmlHttp = new XMLHttpRequest();
		xmlHttp.onreadystatechange = function(){
			if(this.readyState == 4 && this.status == 200) {
	//				document.getElementById("userid").innerHTML=this.responseText;
					var jsUser = JSON.parse(this.responseText);
    //					document.getElementById("name").innerHTML= "Welcome " + jsUser.etunimi;
			}
		}
		xmlHttp.open("POST","/rest/Questionservices/getAllv",true);
		xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
		xmlHttp.send("User=" + <%=user%>);
	}
	</script>
	
</body>
</html>