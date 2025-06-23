/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestion.projets.controller;

import com.mycompany.gestion.projets.model.Equipe;
import com.mycompany.gestion.projets.model.Utilisateur;
import com.mycompany.gestion.projets.service.EquipeService;
import java.util.List;
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
@RequestMapping("/admin")
public class EquipeController {

    @Autowired
    private EquipeService equipeService;

    @GetMapping("/equipes")
    public String listeEquipes(HttpSession session, Model model) {
        Utilisateur utili= (Utilisateur) session.getAttribute("utilisateur");
        if (utili == null) {
            return "redirect:/login";
        }
        List<Equipe> equipes = equipeService.findAll();
        model.addAttribute("equipes", equipes);
        return "admin/equipes"; // /WEB-INF/views/admin/liste_utilisateurs.jsp
    }

    @GetMapping("/equipes/ajouter")
    public String afficherFormulaireAjout(HttpSession session,Model model) {
        Utilisateur utili= (Utilisateur) session.getAttribute("utilisateur");
        if (utili == null) {
            return "redirect:/login";
        }
        model.addAttribute("equipe", new Equipe());
        return "admin/ajouterEquipe";  // ajouter_Equipe.jsp
    }

    @PostMapping("/equipes/ajouter")
    public String ajouterEquipe(@ModelAttribute Equipe equipe) {
        equipeService.save(equipe);
        return "redirect:/admin/equipes";
    }

    @GetMapping("/equipes/modifier")
    public String afficherFormulaireModification(@RequestParam("id") int id,HttpSession session, Model model) {
        Utilisateur utili= (Utilisateur) session.getAttribute("utilisateur");
        if (utili == null) {
            return "redirect:/login";
        }
        Equipe equipe = equipeService.findById(id);
        model.addAttribute("equipe", equipe);
        return "admin/modifierEquipe";  // modifier_equipe.jsp
    }

    @PostMapping("/equipes/modifier")
    public String modifierEquipe(@ModelAttribute Equipe equipe) {
        equipeService.save(equipe);
        return "redirect:/admin/equipes";
    }

    @GetMapping("/equipes/supprimer")
    public String supprimerEquipe(@RequestParam("id") int id) {
        equipeService.delete(id);
        return "redirect:/admin/equipes";
    }


}
