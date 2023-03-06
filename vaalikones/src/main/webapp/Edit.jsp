<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.PersistenceContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="persist.Ehdokkaat"%>
<%@page import="javax.persistence.EntityTransaction"%>
<%@page session="true"%>
<%


String candidateID = request.getParameter("user");
Integer candidatee = Integer.parseInt(candidateID);


EntityManagerFactory emf = null;
EntityManager em = null;
EntityTransaction transaction = null;
try {
	emf = Persistence.createEntityManagerFactory("vaalikones");
	em = emf.createEntityManager();
	transaction = em.getTransaction();
	transaction.begin();
} catch (Exception e) {
	response.getWriter().println("EMF+EM Not working");

	e.printStackTrace(response.getWriter());

	return;
}


// System.out.println(one.getEtunimi());
%>




 <%
 Query qE = em.createQuery(
			
			"SELECT e FROM Ehdokkaat e WHERE e.ehdokasId = :Ehdos").setParameter("Ehdos", candidatee);
	List<Ehdokkaat> kaikkiEhdokkaat = qE.getResultList();
	Ehdokkaat one = kaikkiEhdokkaat.get(0);
        %>

<!DOCTYPE html>
<html>
<head>
<title>Adding Candidate</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>

	<div class="editdiv">
		<br>
		<form class="edit" method="post">
			<h2>Update:</h2>
			<br> <input type="hidden" size="3" name="user"
				value="<%= one.getEhdokasId()%>" />
				Username:<br>
			<input type="text" maxlength="200" size="70" name="username"
				value="<%= one.getUsername()%>" /><br> 
				Password:<br>
			<input type="Password" maxlength="200" size="70" name="password"
				value="<%= one.getPassword()%>" /><br> 
				Etunimi:<br>
			<input type="text" maxlength="200" size="70" name="etunimi"
				value="<%= one.getEtunimi()%>" /><br> 
				Sukunimi:<br>
			<input type="text" maxlength="200" size="70" name="sukunimi"
				value="<%= one.getSukunimi()%>" /><br> 
				Puolue:<br>
			<input type="text" maxlength="200" size="70" name="puolue"
				value="<%= one.getPuolue()%>" /><br> 
				Kotipaikkakunta:<br>
			<input type="text" maxlength="200" size="70" name="paikkakunta"
				value="<%= one.getKotipaikkakunta()%>" /><br> 
				Ikä:<br>
			<input type="text" maxlength="200" size="70" name="ika"
				value="<%= one.getIka()%>" /><br> 
				Miksi eduskuntaan:<br>
			<textarea rows="5" cols="60" name="miksi"> <%= one.getMiksiEduskuntaan()%></textarea>
			<br> 
			Mitä asioita haluat edistää?:<br>
			<textarea rows="5" cols="60"name="mita"><%= one.getMitaAsioitaHaluatEdistaa()%></textarea>
			<br> Ammatti:<br>
			<input type="text" maxlength="200" size="70" name="ammatti"
				value="<%= one.getAmmatti()%>" /><br>
			
			<input type="submit" name="update" value="update" /><a class="buton"
				href="/Admin.jsp ">Cancel</a><br>

		</form>
		<br>
		<%
            if (request.getParameter("update") != null) {
                try {
                    //Retrieve the values set for the candidate from the text fields
                    String id = request.getParameter("user");
                 
                   	int i = Integer.parseInt(id);
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
                    
                    EntityManager as = emf.createEntityManager();
                    EntityTransaction trans = as.getTransaction();
                    
                    
                   
                   
                    
                   	Ehdokkaat eh = as.find(Ehdokkaat.class, i); 
                   
                   	if(eh != null){
                   	 as.getTransaction().begin();	
                   	 eh.setUsername(username);
                   	 eh.setPassword(password);
                   	 eh.setEtunimi(etunimi);
                     eh.setSukunimi(sukunimi);
                     eh.setPuolue(puolue);
                     eh.setKotipaikkakunta(paikka);
                     eh.setIka(ik);
                     eh.setMiksiEduskuntaan(miksi);
                     eh.setMitaAsioitaHaluatEdistaa(mita);
                     eh.setAmmatti(ammatti);
                     
                   
                     
                      as.persist(eh);
                      as.flush();
      				as.getTransaction().commit();
                      as.close();
                      
                   	}
                   	response.getWriter().print("Record Updated");
                   	session.setAttribute("limit-total", 0);
        			session.setAttribute("limitCached", 0);
                   // response.setHeader("Refresh", "0; http://localhost:8080/vaalikone/Edit.jsp");
                    //response.getWriter().print("Record Updated");
                    response.sendRedirect("Admin.jsp");
                } catch (Exception e) {
                	System.out.println(e.getMessage());
               }
            }
%>
	</div>

</body>
</html>