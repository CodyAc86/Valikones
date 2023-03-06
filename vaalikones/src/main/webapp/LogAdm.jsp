<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<% Object error = request.getAttribute("messag");  %>

<!DOCTYPE html>
<html>
    
<head>
        <link href="style.css" rel="stylesheet" type="text/css">
    </head>
    <body>
     
            <img id="headerimg" src="Logo.png" width="720" />
           

	<form id="CheckAdmin" action="CheckAdmin" method="POST">
		<% if (error != null) {out.println(error);%>
		</br>
		<%} else {%>
	 	<p>Sign in<p>
		<%}%>
		<input id="User" type="text" name="User" placeholder="User"><br> 
		<input id="Password" type="password" name="Password" placeholder="Password"> <br> 
		<input id="submit" type="submit" name="Login" value="Login">
	</form>
	</br>
</body>
</html>