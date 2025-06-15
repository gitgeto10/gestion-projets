package com.mycompany.gestion.projets.controller;

import com.mycompany.gestion.projets.model.Tache;
import com.mycompany.gestion.projets.model.Project;
import com.mycompany.gestion.projets.model.Utilisateur;
import com.mycompany.gestion.projets.service.TacheService;
import com.mycompany.gestion.projets.service.ProjectService;
import com.mycompany.gestion.projets.service.UtilisateurService;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 *
 * @author dell
 */

@Controller
@RequestMapping("/chef")
public class TacheController {


    @Autowired
    private TacheService tacheService;
    @Autowired
    private ProjectService projectService;
    @Autowired
    private UtilisateurService utilisateurService;

    @GetMapping("/taches")
    public String listeTaches(HttpSession session, Model model) {
        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) {
            return "redirect:/login";
        }

        int chefId = utilisateur.getId();
        List<Project> projets = projectService.findByChefProjetId(chefId);

        // Récupérer les tâches liées à chaque projet du chef
        List<Tache> taches = new ArrayList<>();
        for (Project projet : projets) {
            List<Tache> tachesProjet = tacheService.findByProjetId(projet.getId());
            taches.addAll(tachesProjet);
        }

        model.addAttribute("taches", taches);
        return "chef/taches"; // /WEB-INF/views/chef/taches.jsp
    }

    @GetMapping("/taches/ajouter")
    public String afficherFormulaireAjout(HttpSession session,Model model) {
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("tache", new Tache());

        // Charger les listes pour les select
        List<Project> projets = projectService.findAll();
        List<Utilisateur> membres = utilisateurService.findAll()
                .stream()
                .filter(utilisateur -> "Membre".equals(utilisateur.getRole()))
                .collect(Collectors.toList());

        model.addAttribute("projets", projets);
        model.addAttribute("membres", membres);


        return "chef/ajouterTache";  // ajouter_tache.jsp
    }

    @PostMapping("/taches/ajouter")
    public String ajouterTache(@ModelAttribute Tache tache) {
        tacheService.save(tache);
        return "redirect:/chef/taches";
    }

    @GetMapping("/taches/modifier")
    public String afficherFormulaireModification(@RequestParam("id") int id, Model model,HttpSession session) {
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");
        if (user == null) {
            return "redirect:/login";
        }
        Tache tache = tacheService.findById(id);
        model.addAttribute("tache", tache);

        // Charger les listes pour les select
        List<Project> projets = projectService.findAll();
        List<Utilisateur> membres = utilisateurService.findAll()
                .stream()
                .filter(utilisateur -> "Membre".equals(utilisateur.getRole()))
                .collect(Collectors.toList());

        model.addAttribute("projets", projets);
        model.addAttribute("membres", membres);

        return "chef/modifierTache";  // modifier_tache.jsp
    }

    @PostMapping("/taches/modifier")
    public String modifierTache(@ModelAttribute Tache tache) {
        tacheService.save(tache);
        return "redirect:/chef/taches";
    }

    @GetMapping("/taches/supprimer")
    public String supprimerTache(@RequestParam("id") int id) {
        tacheService.delete(id);
        return "redirect:/chef/taches";
    }

    @GetMapping("/taches/projet")
    public String tachesByProjet(@RequestParam("projetId") int projetId, Model model) {
        List<Tache> taches = tacheService.findByProjetId(projetId);
        Project projet = projectService.findById(projetId);

        model.addAttribute("taches", taches);
        model.addAttribute("projet", projet);

        return "chef/tachesProjet"; // taches_projet.jsp
    }

    @GetMapping("/taches/membre")
    public String tachesByMembre(@RequestParam("membreId") int membreId, Model model) {
        List<Tache> taches = tacheService.findByMembreId(membreId);
        Utilisateur membre = utilisateurService.findById(membreId);

        model.addAttribute("taches", taches);
        model.addAttribute("membre", membre);

        return "chef/tachesMembre"; // taches_membre.jsp
    }

    @GetMapping("/taches/etat")
    public String tachesByEtat(@RequestParam("etat") String etat, Model model) {
        List<Tache> taches = tacheService.findByEtat(etat);

        model.addAttribute("taches", taches);
        model.addAttribute("etat", etat);

        return "chef/tachesEtat"; // taches_etat.jsp
    }

    @GetMapping("/taches/details")
    public String detailsTache(@RequestParam("id") int id, Model model) {
        Tache tache = tacheService.findById(id);
        Project projet = null;
        Utilisateur membre = null;

        if (tache.getProjetId() != null) {
            projet = projectService.findById(tache.getProjetId());
        }
        if (tache.getMembreId() != null) {
            membre = utilisateurService.findById(tache.getMembreId());
        }

        model.addAttribute("tache", tache);
        model.addAttribute("projet", projet);
        model.addAttribute("membre", membre);

        return "chef/detailsTache"; // details_tache.jsp
    }

    @PostMapping("/taches/changer-etat")
    public String changerEtatTache(@RequestParam("id") int id, @RequestParam("nouvelEtat") String nouvelEtat) {
        Tache tache = tacheService.findById(id);
        if (tache != null) {
            tache.setEtat(nouvelEtat);
            tacheService.save(tache);
        }
        return "redirect:/chef/taches";
    }

    @PostMapping("/taches/assigner-membre")
    public String assignerMembre(@RequestParam("id") int id, @RequestParam("membreId") int membreId) {
        Tache tache = tacheService.findById(id);
        if (tache != null) {
            tache.setMembreId(membreId);
            tacheService.save(tache);
        }
        return "redirect:/chef/taches";
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) {
            return "redirect:/login";
        }
        int id = utilisateur.getId();

        List<Project> projets = projectService.findByChefProjetId(id);
        int nombreProjets = projets.size();
        int nombreTaches = tacheService.countTaches();

        model.addAttribute("nombreProjets", nombreProjets);
        model.addAttribute("nombreTaches", nombreTaches);
        model.addAttribute("projets", projets);

        return "chef/dashboard";
    }

    @GetMapping("/profil")
    public String profil(HttpSession session) {

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) {
            return "redirect:/login";
        }
        return "chef/profil";
    }

    @GetMapping("/projets")
    public String projets(HttpSession session, Model model) {

        Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
        if (utilisateur == null) {
            return "redirect:/login";
        }
        int id = utilisateur.getId();

        List<Project> projets = projectService.findByChefProjetId(id);

        model.addAttribute("projets", projets);

        return "chef/projets";
    }
}