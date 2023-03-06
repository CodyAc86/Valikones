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
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import com.fasterxml.jackson.databind.ObjectMapper;

import persist.Ehdokkaat;
import persist.Kysymykset;
import persist.Vastaukset;



@Path("/questions")
public class Question {
	
	private Ehdokkaat user;
	
	public Question(Ehdokkaat u) {
		user = u; 
	 }
	
	public List<Kysymykset> All(){
		List<Kysymykset> all= new ArrayList<Kysymykset>();
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("vaalikones");
		EntityManager em = emf.createEntityManager();
		EntityTransaction transaction = null;
		try {
			
			
//			transaction = em.getTransaction();
//			transaction.begin();

			Query qE = em.createNamedQuery("Kysymykset.findAll");
			all= (List<Kysymykset>) qE.getResultList();
			//System.out.println("here!");System.out.println(all);
			em.close();

		} catch (Exception e) {
		//	all= new ArrayList<Kysymykset>();
		}
		return all;
	}
	
	/*@Context private HttpServletRequest request;
	@Context private HttpServletResponse response;
	@PUT
	@Path("/question")
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public Kysymykset Question(Vastaukset vastaukset) {
		EntityManagerFactory emf = null;
		EntityManager em = null;
		EntityTransaction transaction = null;
		Kysymykset answer = null;

		try {
			emf = Persistence.createEntityManagerFactory("vaalikones");
			em = emf.createEntityManager();
			transaction = em.getTransaction();
			transaction.begin();

			Query qE = em.createNamedQuery("Vastaukset.findByUniqueID");
			qE.setParameter("ehdokasId",vastaukset.getEhdokasId());
			qE.setParameter("vastaus",vastaukset.getVastaus());
			qE.setParameter("kommentti", vastaukset.getKommentti());
			Kysymykset one = (Kysymykset) qE.getSingleResult();
			
			
			ArrayList<Integer> qID = (ArrayList<Integer>) request.getAttribute("questionID");
			ArrayList<String> questOn = (ArrayList<String>) request.getAttribute("question");
			List<Vastaukset> answer1 = (List<Vastaukset>) request.getAttribute("candidateAnswer");



		for (int j = 1; j <= ((List<Integer>) one).size(); j++) {
				Kysymykset kysymys = em.find(Kysymykset.class, j);
				qID.add(kysymys.getKysymysId());
				questOn.add(kysymys.getKysymys());
				

				request.setAttribute("qID", qID);
				request.setAttribute("questOn", questOn);
				request.setAttribute("answer1", answer1);


				if(one!= null) {
					HttpSession session = request.getSession();
					session.setAttribute("user", one);
					//response.sendRedirect("candidate.jsp");
					answer = one;
				}
				em.getTransaction().commit();
				em.close();
			}

		} catch (Exception e) {

		}

		return answer;


	}*/

	public Vastaukset Answer(Kysymykset quest) {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("vaalikones");
		EntityManager em = emf.createEntityManager();
		EntityTransaction transaction = null;
		Vastaukset ans = null;
		try {
			
			transaction = em.getTransaction();
			transaction.begin();

			Query qE = em.createNamedQuery("Vastaukset.findByUniqueID");
			qE.setParameter("ehdokasId", user.getEhdokasId());
			qE.setParameter("kysymysId", quest.getKysymysId());
			ans = (Vastaukset) qE.getSingleResult();
			//System.out.println("here!");System.out.println(all);
			em.close();

		} catch (Exception e) {
		
		}
		//if quesiton does have an ans, then we create new vastaus,passing ín the userid & kysymysId
		if(ans == null) {
			ans = new Vastaukset(user.getEhdokasId(), quest.getKysymysId());	
			
		}
		
		return ans;
		
	}

	

}

