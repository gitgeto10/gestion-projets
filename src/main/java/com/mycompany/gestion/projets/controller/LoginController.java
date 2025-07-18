package com.mycompany.gestion.projets.controller;

import com.mycompany.gestion.projets.model.Utilisateur;
import com.mycompany.gestion.projets.service.EquipeService;
import com.mycompany.gestion.projets.service.ProjectService;
import com.mycompany.gestion.projets.service.UtilisateurService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private UtilisateurService utilisateurService;
    @Autowired
    private EquipeService equipeService;
    @Autowired
    private ProjectService projectService;
    
    @GetMapping("/login")
    public String loginForm() {
        return "common/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String pwd,
                        HttpSession session,
                        Model model) {

        Utilisateur utilisateur = utilisateurService.login(email, pwd);

        if (utilisateur != null) {
            session.setAttribute("utilisateur", utilisateur);
            String role = utilisateur.getRole().toLowerCase();

            switch (role) {
                case "administrateur":
                    return "redirect:/admin/dashboard";
                case "chefprojet":
                    return "redirect:/chef/dashboard";
                case "membre":
                    return "redirect:/membre/dashboard";
                default:
                    model.addAttribute("error", "Rôle non reconnu !");
                    return "common/login";
            }
        } else {
            model.addAttribute("message", "Email ou mot de passe incorrect");
            return "common/error";
        }
    }

    @PostMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

}
