<%@page import="persist.Ehdokkaat"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.PersistenceContext"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>

<%
	Object error = request.getAttribute("messag");
%>

<%
	//     if (session.getAttribute("admin") != "admin") {

//         request.getRequestDispatcher("LogAdm.jsp")
//                 .forward(request, response);

//     }
//     EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
//   EntityManager em = emf.createEntityManager();
EntityManagerFactory emf = null;
EntityManager em = null;
try {
	emf = Persistence.createEntityManagerFactory("vaalikones");
	em = emf.createEntityManager();
} catch (Exception e) {
	response.getWriter().println("EMF+EM Not Working");

	e.printStackTrace(response.getWriter());

	return;
}
int limit = 0;

//HttpSession sessions = request.getSession();
//int total = 0;
//String temp = (String) session.getAttribute("limit-total");
// int total = Integer.parseInt(session.getAttribute("limit-total").toString());
// int limitCached = Integer.parseInt(session.getAttribute("limitCached").toString());
Integer total = (Integer) session.getAttribute("limit-total");
Integer limitCached = (Integer) session.getAttribute("limitCached");
// response.getWriter().println(temp);
// if (temp != null) {
// 	total = Integer.parseInt(temp);
// }




Query qE = em.createQuery("SELECT e FROM Ehdokkaat e ORDER BY e.ehdokasId");
List<Ehdokkaat> ehdokasList = qE.getResultList();



em.close();
%>

<!-- ____________________________________________________ -->
<!-- _________________<!DOCTYPE html>____________________ -->

<!DOCTYPE html>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">
    <%if (error != null) {%>
    var msg = "<%= error %>"
	alert(msg);
<%}%>
	
</script>
<body>


	<h1>List of Existing Candidate:</h1>
	<form method="post" name="frm" action="searchview.jsp">
		<table border="0" width="300" align="center">
			<tr>
				<td colspan=2 style="font-size: 12pt;" align="center">
					<h2>Search Candidate</h2>
				</td>
			</tr>

			<td><input type="text" name="pid" id="pid" placeholder="Name">
			</td>
			</tr>
			<tr>
				<td colspan=2 align="center"><input type="submit" name="submit"
					value="Search"></td>
			</tr>

		</table>
		<br>
	</form>
<div class="addButton" align="center">
<form action= "Create.jsp">
	<input type="submit" value ="Add Candidate" name="Create">
</form>
</div>
	<!----------------- LOGOUT SESSION ------------>
<div class="addButton" align="center">
	<form action="Logout">
		<input type="submit" value="Logout" name="Logout" />
	</form>
</div>
	<table>
		<thead>
			<tr>

				<th>View</th>
				<th>Id</th>
				<th>Nimi</th>
				<th>Puolue</th>
				<th>Kotipaikkakunta</th>
				<th>Ika</th>
				<!--<th>Miksi</th> -->
				<!--<th>Mita</th> -->
				<th>Ammatti</th>
				<th>Delete</th>
			</tr>
		</thead>
		<tbody>
			<%
				// List all candidate on the machine
			for (int i = 1; i <= ehdokasList.size(); i++) {
				Ehdokkaat one = ehdokasList.get(i - 1);
			%>

			<tr>

				<td><input type="button" value= "View"
					onclick="window.location='View.jsp?user=<%=one.getEhdokasId()%>'"></a> 
					<input type="button" value= "Edit"
					onclick="window.location='Edit.jsp?user=<%=one.getEhdokasId()%>'"></a>
				</td>	
				<td><%=one.getEhdokasId()%></td>
				<td><%=one.getEtunimi() + " " + one.getSukunimi()%></td>
				<td><%=one.getPuolue()%></td>
				<td><%=one.getKotipaikkakunta()%></td>
				<td><%=one.getIka()%></td>
				<%--<td><%=ehdokasList.get(i - 1).getMiksiEduskuntaan()%></td> --%>
				<%--<td><%=ehdokasList.get(i - 1).getMitaAsioitaHaluatEdistaa()%></td> --%>
				<td><%=one.getAmmatti()%></td>
				<td align="center"><form action="DeleteCandidate" method="POST">					
					<input type="hidden" size ="3" name="id" value="<%=one.getEhdokasId()%>"/>
					<input type="submit" name="Delete"  value="Delete" ></form></td>
					
			</tr>
			<%
				}
			%>
		</tbody>
	</table>





	

	
</body>
</html>