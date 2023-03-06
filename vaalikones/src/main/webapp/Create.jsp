<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.PersistenceContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="persist.Ehdokkaat"%>
<%@page session="true"%>
<!DOCTYPE html>
<html>
<head>
<title>Adding Candidate</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%
		
		%>
		<div id="container">
		<img id="headerimg" src="Logo.png" width="720" />
		
		<%
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
		Query qE = em.createQuery("SELECT e FROM Ehdokkaat e ORDER BY e.ehdokasId");
		List<Ehdokkaat> kaikkiEhdokkaat = qE.getResultList();
		%>
		            <form>
		                <br><br><br><Strong>List of existing candidates:</Strong><br> 
		                <select>
		                    <%  // List all candidates in the database
		                        for (int i = 1; i <= kaikkiEhdokkaat.size(); i++) {%>
		                    <option><%= kaikkiEhdokkaat.get(i - 1).getEhdokasId()%>. <%= kaikkiEhdokkaat.get(i - 1).getEtunimi() + " " + kaikkiEhdokkaat.get(i - 1).getSukunimi()%></option>
		                    <% }%>
		            </select> 
		        </form><br> 

		<form method="post">
			<Strong>Add New:</Strong><br><br> 
			Etunimi:<br> <input	type="text" maxlength="200" size="70" name="etunimi" /><br>
			Username:<br><input	type="User" maxlength="200" size="70" name="username" /><br>
			Password:<br><input	type="password" maxlength="200" size="70" name="password" /><br>
			Sukunimi:<br> <input type="text" maxlength="200" size="70"
				name="sukunimi" /><br> Puolue:<br> <input type="text"
				maxlength="200" size="70" name="puolue" /><br>
			Kotipaikkakunta:<br> <input type="text" maxlength="200"
				size="70" name="paikkakunta" /><br> Ikä:<br> <input
				type="text" maxlength="200" size="70" name="ika" /><br> Miksi
			eduskuntaan:<br> <input type="text" maxlength="200" size="70"
				name="miksi" /><br> Mitä asioita haluat edistää?:<br> <input
				type="text" maxlength="200" size="70" name="mita" /><br>
			Ammatti:<br> <input type="text" maxlength="200" size="70"
				name="ammatti" /><br> <input type="submit" name="Add"
				value="Add" /><br>
		</form>
		<br>
		<%
			if (request.getParameter("Add") != null) {
			try {
				// Retrieve the values set for the candidate from the text fields
				//String id = request.getParameter("id");
				//  System.out.println(id);
				// int i = Integer.parseInt(id);
				String username = request.getParameter("username");
				String password = request.getParameter("password");
				String etunimi = request.getParameter("etunimi");
				String sukunimi = request.getParameter("sukunimi");
				String puolue = request.getParameter("puolue");
				String paikka = request.getParameter("paikkakunta");
				String ika = request.getParameter("ika");
				int ik = Integer.parseInt(ika);
				String miksi = request.getParameter("miksi");
				String mita = request.getParameter("mita");
				String ammatti = request.getParameter("ammatti");
				// A new candidate entity is created that receives the previously set values
				Ehdokkaat e = new Ehdokkaat();
				e.setUsername(username);
				e.setPassword(password);
				e.setEtunimi(etunimi);
				e.setSukunimi(sukunimi);
				e.setPuolue(puolue);
				e.setKotipaikkakunta(paikka);
				e.setIka(ik);
				e.setMiksiEduskuntaan(miksi);
				e.setMitaAsioitaHaluatEdistaa(mita);
				e.setAmmatti(ammatti);
				// System.out.println(e.toString());
				// Export the candidate to the database
				em.getTransaction().begin();
				em.persist(e);
				em.flush();
				em.getTransaction().commit();
				em.close();
				//response.getWriter().print("Record Added");
				//response.setHeader("Refresh", "0; http://localhost:8080/vaalikone/Admin.jsp");
				session.setAttribute("limit-total", 0);
				session.setAttribute("limitCached", 0);
				response.sendRedirect("Admin.jsp");
			} catch (Exception e) {
		%>
		Something went wrong, check id.
		<%
			}
		}
		%>		
		
		<br> <a href="Admin.jsp">Back</a>
	</div>
</body>
</html>