package vaalikone;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import persist.Ehdokkaat;

/**
 * Servlet implementation class CheckCandidate
 */
// @WebServlet("/CheckCandidate")
public class CheckCandidate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckCandidate() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	  protected void processRequest(HttpServletRequest request, HttpServletResponse
	  response) 
			  throws ServletException, IOException {
	  response.setContentType("text/html;charset=UTF-8");
	  
	  System.out.println(request);
	  	final String Password = request.getParameter("Password");
		final String User = request.getParameter("Username");
		
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("vaalikones");
		EntityManager em = emf.createEntityManager();
		Query qE = em.createQuery("SELECT e FROM Ehdokkaat AS e WHERE e.username='" + User + "' AND e.password='" + Password + "'");
		List<Ehdokkaat> ehdokasList = qE.getResultList();
		
		if(ehdokasList==null || ehdokasList.size()==0) {
			String error = "User or Password  is wrong!";
			request.setAttribute("errormessage", error);
//			response.sendRedirect("LogCandidate.jsp");
			RequestDispatcher rd = request.getRequestDispatcher("LogCandidate.jsp");
			rd.forward(request,response);
			return;
		}
			Ehdokkaat pwd = ehdokasList.get(0);
			em.close();
		
		final String dbusername = pwd.getUsername();
		final String dbpassword = pwd.getPassword();
		
			if (crypt(Password).equals(crypt(dbpassword)) && User.equals(dbusername)) {
			HttpSession session = request.getSession();
			int ActiveUser= pwd.getEhdokasId();
			session.setAttribute(dbusername, dbpassword);
			session.setAttribute("limit-total", 0);
			session.setAttribute("limitCached", 0);
			request.setAttribute("User","" + ActiveUser);
			RequestDispatcher rd = request.getRequestDispatcher("Candidate.jsp");
			
			rd.forward(request,response);
			} else {
			String error = "User or Password  is wrong!";
			request.setAttribute("errormessage", error);
//			response.sendRedirect("LogCandidate.jsp");
			RequestDispatcher rd = request.getRequestDispatcher("LogCandidate.jsp");
			rd.forward(request,response);
			}
		
}
	  
	

	 
	public String crypt(String str) {
		if (str == null || str.length() == 0) {
			//throw new IllegalArgumentException("String to encrypt cannot be null or zero length");
			return "";
		}

		MessageDigest digester;
		try {
			digester = MessageDigest.getInstance("MD5");

			digester.update(str.getBytes());
			byte[] hash = digester.digest();
			StringBuffer hexString = new StringBuffer();
			for (int i = 0; i < hash.length; i++) {
				if ((0xff & hash[i]) < 0x10) {
					hexString.append("0" + Integer.toHexString((0xFF & hash[i])));
				} else {
					hexString.append(Integer.toHexString(0xFF & hash[i]));
				}
			}
			return hexString.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return "";
		
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
//		doGet(request, response);
		processRequest(request, response);
		
	}
}
