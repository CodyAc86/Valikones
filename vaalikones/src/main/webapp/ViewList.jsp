<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.TransactionRequiredException"%>
<%@page import ="javax.persistence.PersistenceContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="persist.Ehdokkaat" %>
<%@page session="true"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Adding Candidate</title>
        <link href="style.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <%
            // Check if the "admin" session exists and if not then redirect to login
        // System.out.println(session.getAttribute("admin"));
           /* if (session.getAttribute("admin") != "admin") {
                request.getRequestDispatcher("LogAdm.jsp")
                        .forward(request, response);
            }*/
        %>
        <div id="container">
            <img id="headerimg" src="Logo.png" width="720" />
            <h1>Add & Delete Candidates</h1>
            <%
                // Creating an EntityManager object
               /* EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
                EntityManager em = emf.createEntityManager();
                // Haetaan ehdokkaat listaan tietokannasta
                Query q = em.createQuery(
                        "SELECT e FROM Ehdokkaat e ORDER BY e.ehdokasId");
                List<Ehdokkaat> kaikkiEhdokkaat = q.getResultList();*/
                
                EntityManagerFactory emf=null;
                EntityManager em = null;
                try {
            	      emf=Persistence.createEntityManagerFactory("vaalikones");
            	      em = emf.createEntityManager();
                }
                catch(Exception e) {
                  	response.getWriter().println("EMF+EM Not Working");
                  	
                  	e.printStackTrace(response.getWriter());
                  	
                  	return;
                }
                Query qE = em.createQuery(
                        "SELECT e FROM Ehdokkaat e ORDER BY e.ehdokasId");
                List<Ehdokkaat> kaikkiEhdokkaat = qE.getResultList();
            %> 
<!--             <form> -->
<!--                 <b>Display existing candidates:</b></br> -->
<!--                 <Table> -->
<%--                     <%  // List all candidates in the database--%>
<%--                         for (int i = 1; i <= kaikkiEhdokkaat.size(); i++) {%> --%>
<%--                 <option><%= kaikkiEhdokkaat.get(i-1).getEhdokasId()%>. <%= kaikkiEhdokkaat.get(i - 1).getEtunimi() + " " + kaikkiEhdokkaat.get(i - 1).getSukunimi()%></option> --%>
                    
<!--                     out.print("<tr><td>"+i.getId()+"</td><td>"+i.getEtunimi()+"</td><td>"+i.getSukunimi()+"</td>   -->
<!--                             <td>"+i.getPuolue()+"</td><td>"+i.getKotipaikkakunta()+"+i.getIkä()+"+i.getMiksiEduskuntaan()+"+i.getMitaAsioitaHaluatEdistaa()+"+i.getAmmatti() +"</td><td>+"</td><td>+"</td><td>+"</td><td><a href='Create?id="+e.getId()+"'>edit</a></td>   -->
<!--                             <td><a href='Create?id="+e.getId()+"'>delete</a></td></tr>");   -->
<!--                    }   -->
<!--                    out.print("</table>");   -->
                        
                    
                </Table>
            </form></br>
