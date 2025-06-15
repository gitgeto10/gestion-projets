package com.mycompany.gestion.projets.controller;

import com.mycompany.gestion.projets.model.Livrable;
import com.mycompany.gestion.projets.model.Project;
import com.mycompany.gestion.projets.model.Tache;
import com.mycompany.gestion.projets.model.Utilisateur;
import com.mycompany.gestion.projets.service.LivrableService;
import com.mycompany.gestion.projets.service.ProjectService;
import com.mycompany.gestion.projets.service.TacheService;

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

@Controller
@RequestMapping("/membre")
public class MembreController {

    @Autowired
    private TacheService tacheService;

    @Autowired
    private ProjectService projectService;

    @Autowired
    private LivrableService livrableService;

    // === 1. Tableau de bord membre ===
    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");
        if (user == null || !user.getRole().equalsIgnoreCase("membre")) {
            return "redirect:/login";
        }

        int tacheCount = tacheService.countByUserId(user.getId());
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
        model.addAttribute("taches", taches);

        return "membre/mesTaches";
    }

    // === 3. Formulaire de soumission de livrable ===
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

    Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");
    if (user == null) {
        return "redirect:/login";
    }

    if (fichier != null && !fichier.isEmpty()) {
        String nomFichier = fichier.getOriginalFilename();
        // Tu peux enregistrer le fichier ici si nécessaire
        livrable.setFichierNom(nomFichier);
    }

    livrable.setDateDepot(Date.valueOf(LocalDate.now()));
    livrable.setTacheId(tacheId); // important

    livrableService.soumettreLivrable(livrable);
    return "redirect:/membre/mesTaches";
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
}
