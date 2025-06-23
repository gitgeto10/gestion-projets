package com.mycompany.gestion.projets.controller;

import com.mycompany.gestion.projets.model.Livrable;
import com.mycompany.gestion.projets.model.Project;
import com.mycompany.gestion.projets.model.Tache;
import com.mycompany.gestion.projets.model.TempsTravail;
import com.mycompany.gestion.projets.model.Utilisateur;
import com.mycompany.gestion.projets.service.LivrableService;
import com.mycompany.gestion.projets.service.ProjectService;
import com.mycompany.gestion.projets.service.TacheService;
import com.mycompany.gestion.projets.service.TempsTravailService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/membre")
public class MembreController {

    @Autowired
    private TacheService tacheService;

    @Autowired
    private ProjectService projectService;

    @Autowired
    private LivrableService livrableService;
    
    @Autowired
    private TempsTravailService tempsTravailService;
    
    // === 1. Tableau de bord membre ===
    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");
        if (user == null || !user.getRole().equalsIgnoreCase("membre")) {
            return "redirect:/login";
        }

        int tacheCount = tacheService.countByMembreId(user.getId());
        int projetCount = projectService.countProjetsByMembreId(user.getId());

        model.addAttribute("tacheCount", tacheCount);
        model.addAttribute("projetCount", projetCount);

        return "membre/dashboard";
    }

    // === 2. Liste des tâches du membre ===
    @GetMapping("/mesTaches")
    public String mesTaches(Model model, HttpSession session) {
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");
        if (user == null) {
            return "redirect:/login";
        }

        List<Tache> taches = tacheService.getTachesPourMembre(user.getId());
        for (Tache t : taches) {
            TempsTravail temps = tempsTravailService.findByTacheIdAndMembreId(t.getId(), user.getId());
            t.setTempsDeclare(temps != null);
        }
        model.addAttribute("taches", taches);
            return "membre/mesTaches";

    }
    @GetMapping("/mesLivrables")
    public String afficherLivrables(Model model, HttpSession session) {
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");
        if (user == null || !user.getRole().equalsIgnoreCase("membre")) {
            return "redirect:/login";
        }

        try {
            // Récupérer la liste des tâches du membre
            List<Tache> taches = tacheService.getTachesPourMembre(user.getId());
            List<Integer> tacheIds = taches.stream()
                                          .map(Tache::getId)
                                          .collect(Collectors.toList());

            // Récupérer les livrables associés à ces tâches
            List<Livrable> livrables = livrableService.getLivrablesByTaches(tacheIds);

            model.addAttribute("livrables", livrables);
        } catch (SQLException e) {
            e.printStackTrace();
            model.addAttribute("error", "Erreur lors de la récupération des livrables.");
        }

        return "membre/mesLivrables";
    }

    // Formulaire de soumission de livrable ===
    @GetMapping("/soumettreLivrable")
    public String afficherFormulaireSoumission(@RequestParam("tacheId") Integer tacheId, Model model, HttpSession session) {
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");
        if (user == null) {
            return "redirect:/login";
        }

        Livrable livrable = new Livrable();
        livrable.setTacheId(tacheId);
        model.addAttribute("livrable", livrable);

        return "membre/soumettreLivrable";
    }


@PostMapping("/soumettreLivrable")
public String soumettreLivrable(@ModelAttribute Livrable livrable,
                                @RequestParam("fichier") MultipartFile fichier,
                                @RequestParam("tacheId") int tacheId,
                                HttpSession session) {
    try {
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");
        if (user == null) {
            return "redirect:/login";
        }
        if (fichier != null && !fichier.isEmpty()) {
            String nomFichier = fichier.getOriginalFilename();
            livrable.setFichierNom(nomFichier);
        }
        livrable.setDateDepot(Date.valueOf(LocalDate.now()));
        livrable.setTacheId(tacheId);
        livrableService.soumettreLivrable(livrable);

        
        tacheService.changerEtatTache(tacheId, "Terminé");

        return "redirect:/membre/mesTaches";
    } catch (Exception e) {
        e.printStackTrace();
        // tu peux aussi ajouter un message d'erreur dans le model et retourner une page d'erreur personnalisée
        return "error"; // ou une autre page d’erreur custom
    }
}



@GetMapping("/mesProjets")
public String afficherMesProjets(Model model, HttpSession session) {
    Utilisateur membre = (Utilisateur) session.getAttribute("utilisateur");
    if (membre == null || !membre.getRole().equalsIgnoreCase("membre")) {
        return "redirect:/login";
    }

    List<Project> projets = projectService.getProjetsParMembreId(membre.getId());
    model.addAttribute("projets", projets);
    return "membre/mesProjets";
}

@GetMapping("/modifierLivrable")
public String afficherFormulaireModification(@RequestParam("id") int livrableId, Model model, HttpSession session) {
    Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");
    if (user == null || !user.getRole().equalsIgnoreCase("membre")) {
        return "redirect:/login";
    }

    Livrable livrable = livrableService.getLivrableById(livrableId);
    model.addAttribute("livrable", livrable);

    return "membre/modifierLivrable";
}
@PostMapping("/modifierLivrable")
public String modifierLivrable(@ModelAttribute Livrable livrable,
                               @RequestParam("fichier") MultipartFile fichier) throws SQLException {

    if (fichier != null && !fichier.isEmpty()) {
        String nouveauNomFichier = fichier.getOriginalFilename();
        livrable.setFichierNom(nouveauNomFichier);
        // tu peux aussi enregistrer le nouveau fichier ici
    } else {
        // On récupère l'ancien fichier pour le conserver
        Livrable ancien = livrableService.getLivrableById(livrable.getId());
        livrable.setFichierNom(ancien.getFichierNom());
    }

    livrable.setDateDepot(Date.valueOf(LocalDate.now()));
    livrableService.modifierLivrable(livrable);

    return "redirect:/membre/mesTaches";
}

@GetMapping("/profil")
public String profil(Model model, HttpSession session) {
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
    if (utilisateur == null) {
        return "redirect:/login";
    }
    model.addAttribute("utilisateur", utilisateur);
    return "membre/profil"; 
}
}
