package services;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import persist.Ehdokkaat;
import persist.Vastaukset;

@SuppressWarnings("unused")
@Path("/candidateService")
public class CandidateService {


	@Context private HttpServletRequest request;
	@Context private HttpServletResponse response;
	@POST
	@Path("/login")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Ehdokkaat login(Ehdokkaat ehdokkaat) {
		System.out.println("login");
		EntityManagerFactory emf = null;
		EntityManager em = null;
		EntityTransaction transaction = null;
		Ehdokkaat result = null;
		try {
			emf = Persistence.createEntityManagerFactory("vaalikones");
			em = emf.createEntityManager();
			transaction = em.getTransaction();
			transaction.begin();

			Query qE = em.createNamedQuery("Ehdokkaat.findByFullName");
			qE.setParameter("etunimi",ehdokkaat.getEtunimi());
			qE.setParameter("sukunimi", ehdokkaat.getSukunimi());
			Ehdokkaat one = (Ehdokkaat) qE.getSingleResult();

			if(one!= null) {
				HttpSession session = request.getSession();
				session.setAttribute("user", one);
				//response.sendRedirect("candidate.jsp");
				result = one;
			}

			em.close();

		} catch (Exception e) {

		}

		return result;

	}

	@POST
	@Path("/save")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Vastaukset save(Vastaukset ans) {
		EntityManagerFactory emf = null;
		EntityManager em = null;
		EntityTransaction transaction = null;
		try {
			emf = Persistence.createEntityManagerFactory("vaalikones");
			em = emf.createEntityManager();
			transaction = em.getTransaction();
			transaction.begin();
			Query qE = em.createNamedQuery("Vastaukset.findByUniqueID");
			qE.setParameter("ehdokasId", ans.getVastauksetPK().getEhdokasId());
			qE.setParameter("kysymysId", ans.getVastauksetPK().getKysymysId());
			Vastaukset v = (Vastaukset) qE.getSingleResult(); 
			if(v== null) {
				em.persist(ans);
			}
			else {
				v.setVastaus(ans.getVastaus());
				 
			}
			transaction.commit(); 
			em.close();

		} catch (Exception e) {

		}

		return ans;

	}


}
