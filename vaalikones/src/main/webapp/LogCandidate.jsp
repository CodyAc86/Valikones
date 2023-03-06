<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <% Object error = request.getAttribute("errormessage");  %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="style.css" rel="stylesheet" type="text/css">
<title>Candidate Login</title>
</head>
<body>
<img id="headerimg" src="Logo.png" width="720" />
           

	<form id="CheckAdmin" action="CheckCandidate" method="POST">
		<% if (error != null) {out.println(error);%>
		</br>
		<%} else {%>
	 	<p>Sign in<p>
		<%}%>
		<input id="User" type="text" name="Username" placeholder="User"><br> 
		<input id="Password" type="password" name="Password" placeholder="Password"> <br> 
		<input id="submit" type="submit" name="Login" value="Login">
	</form>
	</br>
</body>
</html>