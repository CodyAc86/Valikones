package vaalikone;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//@WebServlet("/CheckAdmin")
public class CheckAdmin extends HttpServlet {

	
	private static final long serialVersionUID = 1L;

	 public CheckAdmin() {
	        super();
	        // TODO Auto-generated constructor stub
	    }

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");

		System.out.println(request);
		
		
		final String Password = request.getParameter("Password");
		final String User = request.getParameter("User");

		if (crypt(Password).equals(crypt("admin")) && User.equals("admin")) {
			HttpSession session = request.getSession();
			session.setAttribute("login", "login");
			session.setAttribute("limit-total", 0);
			session.setAttribute("limitCached", 0);
			/*request.getRequestDispatcher("Admin.jsp")
			.forward(request, response);*/
			response.sendRedirect("Admin.jsp");
		} else {
			String error = "User or Password  is wrong!";
			request.setAttribute("messag", error);
			/*request.getRequestDispatcher("LogAdm.jsp")
			.forward(request, response);*/
			response.sendRedirect("LogAdm.jsp");

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
	 // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    	//System.out.println(request);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}