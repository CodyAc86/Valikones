<%@ page import="java.util.*"%>
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
	Object error = request.getAttribute("viesti");
%>

<%
	/* EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
 EntityManager em = emf.createEntityManager();*/
EntityManagerFactory emf = null;
EntityManager em = null;
String name = request.getParameter("pid");
try {
	emf = Persistence.createEntityManagerFactory("vaalikones");
	em = emf.createEntityManager();
} catch (Exception e) {
	response.getWriter().println("EMF+EM EI Onnistu");
	e.printStackTrace(response.getWriter());
	return;
}
Query qE = em.createQuery("SELECT e FROM Ehdokkaat AS e WHERE e.etunimi='" + name + "' OR e.sukunimi='" + name + "'");
List<Ehdokkaat> ehdokasList = qE.getResultList();
em.close();
%>

<!DOCTYPE html>
<html>
<head>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<script type="text/javascript">
    <%if (error != null) {%>
    var msg = "<%=error%>
	";
	alert(msg);
<%}%>
	
</script>
<body>


	<a href="Create.jsp" class="button">Add & Delete Candidate</a>




	<h1>List of Searched Candidate:</h1>
	<%
		Integer limitCached = (Integer) session.getAttribute("limitCached");
	String paged = "";
	if (limitCached > 0) {
		paged = "?paged=" + limitCached;
	}
	%>
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
					value="Search"> <a id="cancel" href="/Admin.jsp">Cancel</a></td>

			</tr>

		</table>
	</form>
	<script>
		function goBack() {
			window.history.back();
		}
	</script>

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
					
				<td><%=one.getEhdokasId()%></td>
				<td><%=one.getEtunimi() + " " + one.getSukunimi()%></td>
				<td><%=one.getPuolue()%></td>
				<td><%=one.getKotipaikkakunta()%></td>
				<td><%=one.getIka()%></td>
				<%--<td><%=ehdokasList.get(i - 1).getMiksiEduskuntaan()%></td> --%>
				<%--<td><%=ehdokasList.get(i - 1).getMitaAsioitaHaluatEdistaa()%></td> --%>
				<td><%=one.getAmmatti()%></td>
				<td><form action="DeleteCandidate" method="POST">					
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