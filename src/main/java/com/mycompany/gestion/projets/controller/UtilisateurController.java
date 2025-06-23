/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestion.projets.controller;

import com.mycompany.gestion.projets.model.Utilisateur;
import com.mycompany.gestion.projets.service.EquipeService;
import com.mycompany.gestion.projets.service.UtilisateurService;
import com.mycompany.gestion.projets.service.ProjectService;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author dell
 */

@Controller
@RequestMapping("/admin")
public class UtilisateurController {

    @Autowired
    private UtilisateurService utilisateurService;
    @Autowired
    private EquipeService equipeService;
    @Autowired
    private ProjectService projectService;

    @GetMapping("/utilisateurs")
    public String listeUtilisateurs(Model model) {
        List<Utilisateur> utilisateurs = utilisateurService.findAll();
        model.addAttribute("utilisateurs", utilisateurs);
        return "admin/utilisateurs"; 
    }

    @GetMapping("/utilisateurs/ajouter")
    public String afficherFormulaireAjout(Model model) {
        model.addAttribute("utilisateur", new Utilisateur());
        return "admin/ajouterUtilisateur";  // ajouter_utilisateur.jsp
    }

    @PostMapping("/utilisateurs/ajouter")
    public String ajouterUtilisateur(@ModelAttribute Utilisateur utilisateur) {
        utilisateurService.save(utilisateur);
        return "redirect:/admin/utilisateurs";
    }

    @GetMapping("/utilisateurs/modifier")
    public String afficherFormulaireModification(@RequestParam("id") int id, Model model) {
        Utilisateur utilisateur = utilisateurService.findById(id);
        model.addAttribute("utilisateur", utilisateur);
        return "admin/modifierUtilisateur";  // modifier_utilisateur.jsp
    }

    @PostMapping("/utilisateurs/modifier")
    public String modifierUtilisateur(@ModelAttribute Utilisateur utilisateur) {
        utilisateurService.save(utilisateur);
        return "redirect:/admin/utilisateurs";
    }

    @GetMapping("/utilisateurs/supprimer")
    public String supprimerUtilisateur(@RequestParam("id") int id) {
        utilisateurService.delete(id);
        return "redirect:/admin/utilisateurs";
    }
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        int totalUtilisateurs = utilisateurService.countUtilisateurs();
        model.addAttribute("totalUtilisateurs", totalUtilisateurs);
        int totalEquipes = equipeService.countEquipes();
        model.addAttribute("totalEquipes", totalEquipes);
        int totalProjets = projectService.countProjects();
        model.addAttribute("totalProjets", totalProjets);
        return "admin/dashboard"; // fichier JSP
    }
    
   @GetMapping("/profil")
public String profil(Model model, HttpSession session) {
    Utilisateur utilisateur = (Utilisateur) session.getAttribute("utilisateur");
    if (utilisateur == null) {
        return "redirect:/login";
    }
    model.addAttribute("utilisateur", utilisateur);
    return "admin/profil";  
}
 
}
