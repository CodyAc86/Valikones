package vaalikone;

import java.io.IOException;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import persist.Ehdokkaat;

/**
 * Servlet implementation class DeleteCandidate
 */
//@WebServlet("/DeleteCandidate")
public class DeleteCandidate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteCandidate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
			String id = request.getParameter("id");
			int i = Integer.parseInt(id);
			// Retrieve the candidate from the database and delete it
			
			
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("vaalikones");
			EntityManager em = emf.createEntityManager();
			Ehdokkaat e = em.find(Ehdokkaat.class, i);
			em.getTransaction().begin();
			em.remove(e);
			em.getTransaction().commit();			
			response.sendRedirect("Admin.jsp");			
			em.close();
			
		
	}

}
