package services;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;

import persist.Ehdokkaat;
import persist.Kysymykset;
import persist.Vastaukset;

@Path("/Questionservices")
public class Questionservices {

	@Path("/getCandidate")
	@POST	
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes("application/x-www-form-urlencoded")
	public Ehdokkaat postCandidate(@FormParam ("User") int user) {
		System.out.println("user=" + user);
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("vaalikones");
		EntityManager em = emf.createEntityManager();
		Ehdokkaat e = em.find(Ehdokkaat.class, user);
		em.close();
		return e;
	}
	
	
	@Path("/getAllq")
	@GET	
	@Produces(MediaType.APPLICATION_JSON)
	
	public List<Kysymykset> getAllq () {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("vaalikones");
		EntityManager em = emf.createEntityManager();
		Query qE = em.createQuery("SELECT k FROM Kysymykset k");
		List<Kysymykset> kysymyksetList = qE.getResultList();
		
		em.close();
		return kysymyksetList;
	}
	
	@Path("/getAllv")
	@POST	
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public List<Vastaukset> getAllv (String user) {
		int id = Integer.parseInt(user);
		System.out.println("user=" + user);
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("vaalikones");
		EntityManager em = emf.createEntityManager();
//		Ehdokkaat e = em.find(Ehdokkaat.class, id);
//		int userid = e.getEhdokasId();
		
		
		Query qE = em.createQuery("SELECT v FROM Vastaukset v WHERE v.vastauksetPK.ehdokasId=" + id);
//		Query qE = em.createQuery("SELECT v FROM Vastaukset v");
		List<Vastaukset> vastauksetList = qE.getResultList();
		if (vastauksetList == null) {
			vastauksetList = new ArrayList<Vastaukset>();
		}
		em.close();
		return vastauksetList;
	}
	
}
