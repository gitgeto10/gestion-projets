/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestion.projets.controller;

import com.mycompany.gestion.projets.model.Project;
import com.mycompany.gestion.projets.model.Equipe;
import com.mycompany.gestion.projets.model.Utilisateur;
import com.mycompany.gestion.projets.service.ProjectService;
import com.mycompany.gestion.projets.service.EquipeService;
import com.mycompany.gestion.projets.service.UtilisateurService;
import java.util.List;
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
public class ProjectController {

    @Autowired
    private ProjectService projectService;
    @Autowired
    private EquipeService equipeService;
    @Autowired
    private UtilisateurService utilisateurService;

    @GetMapping("/projets")
    public String listeProjets(Model model) {
        List<Project> projets = projectService.findAll();
        model.addAttribute("projets", projets);
        return "admin/projets"; // /WEB-INF/views/admin/projets.jsp
    }

    @GetMapping("/projets/ajouter")
    public String afficherFormulaireAjout(Model model) {
        model.addAttribute("project", new Project());

        // Charger les listes pour les select
        List<Equipe> equipes = equipeService.findAll();
        List<Utilisateur> chefsProjets = utilisateurService.findAll(); // ou filtrer par rôle ChefProjet

        model.addAttribute("equipes", equipes);
        model.addAttribute("chefsProjets", chefsProjets);

        return "admin/ajouterProject";  // ajouter_project.jsp
    }

    @PostMapping("/projets/ajouter")
    public String ajouterProject(@ModelAttribute Project project) {
        projectService.save(project);
        return "redirect:/admin/projets";
    }

    @GetMapping("/projets/modifier")
    public String afficherFormulaireModification(@RequestParam("id") int id, Model model) {
        Project project = projectService.findById(id);
        model.addAttribute("project", project);

        // Charger les listes pour les select
        List<Equipe> equipes = equipeService.findAll();
        List<Utilisateur> chefsProjets = utilisateurService.findAll(); // ou filtrer par rôle ChefProjet

        model.addAttribute("equipes", equipes);
        model.addAttribute("chefsProjets", chefsProjets);

        return "admin/modifierProject";  // modifier_project.jsp
    }

    @PostMapping("/projets/modifier")
    public String modifierProject(@ModelAttribute Project project) {
        projectService.save(project);
        return "redirect:/admin/projets";
    }

    @GetMapping("/projets/supprimer")
    public String supprimerProject(@RequestParam("id") int id) {
        projectService.delete(id);
        return "redirect:/admin/projets";
    }

    @GetMapping("/projets/equipe")
    public String projetsByEquipe(@RequestParam("equipeId") int equipeId, Model model) {
        List<Project> projets = projectService.findByEquipeId(equipeId);
        Equipe equipe = equipeService.findById(equipeId);

        model.addAttribute("projets", projets);
        model.addAttribute("equipe", equipe);

        return "admin/projetsEquipe"; // projets_equipe.jsp
    }

    @GetMapping("/projets/chef")
    public String projetsByChef(@RequestParam("chefId") int chefId, Model model) {
        List<Project> projets = projectService.findByChefProjetId(chefId);
        Utilisateur chef = utilisateurService.findById(chefId);

        model.addAttribute("projets", projets);
        model.addAttribute("chef", chef);

        return "admin/projetsChef"; // projets_chef.jsp
    }

    @GetMapping("/projets/details")
    public String detailsProject(@RequestParam("id") int id, Model model) {
        Project project = projectService.findById(id);
        Equipe equipe = equipeService.findById(project.getEquipeId());
        Utilisateur chefProjet = utilisateurService.findById(project.getChefProjetId());

        model.addAttribute("project", project);
        model.addAttribute("equipe", equipe);
        model.addAttribute("chefProjet", chefProjet);

        return "admin/detailsProject"; // details_project.jsp
    }
}