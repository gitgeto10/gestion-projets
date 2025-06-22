package com.mycompany.gestion.projets.controller;

import com.mycompany.gestion.projets.model.TempsTravail;
import com.mycompany.gestion.projets.model.Tache;
import com.mycompany.gestion.projets.model.Utilisateur;
import com.mycompany.gestion.projets.service.TempsTravailService;
import com.mycompany.gestion.projets.service.TacheService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/membre/temps")
public class TempsTravailController {

    @Autowired
    private TempsTravailService tempsTravailService;

    @Autowired
    private TacheService tacheService;

    @GetMapping("/ajouter")
    public String afficherFormAjout(@RequestParam(value = "tacheId", required = false) Integer tacheId, Model model, HttpSession session) {
        Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");
        if (user == null) return "redirect:/login";

        List<Tache> taches = tacheService.findByMembreId(user.getId());
        model.addAttribute("taches", taches);

        TempsTravail temps = new TempsTravail();
        if (tacheId != null) {
            temps.setTacheId(tacheId);
        }

        model.addAttribute("temps", temps);
        return "membre/ajouterTemps";
    }

    @PostMapping("/ajouter")
public String enregistrerTemps(@ModelAttribute TempsTravail temps,
                               HttpSession session,
                               RedirectAttributes redirectAttributes) {

    Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");
    if (user == null) return "redirect:/login";

    temps.setDate(new Date());
    temps.setMembreId(user.getId());

    Tache tache = tacheService.findById(temps.getTacheId());

    // Message selon dépassement
    if (temps.getDuree() > tache.getDureeEstimee()) {
        redirectAttributes.addFlashAttribute("info", " La durée déclarée dépasse la durée estimée !");
    } else {
        redirectAttributes.addFlashAttribute("info", " Temps enregistré avec succès !");
    }

    tempsTravailService.save(temps);

    return "redirect:/membre/mesTaches";
}
@GetMapping("/modifier")
public String afficherFormModification(@RequestParam("tacheId") int tacheId, Model model, HttpSession session) {
    Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");
    if (user == null) return "redirect:/login";
    
    List<Tache> taches = tacheService.findByMembreId(user.getId());
    model.addAttribute("taches", taches);
    TempsTravail temps = tempsTravailService.findByTacheIdAndMembreId(tacheId, user.getId());
    if (temps == null) {
        return "redirect:/membre/mesTaches";
    }


    model.addAttribute("temps", temps);
    return "membre/modifierTemps";
}


@PostMapping("/modifier")
public String modifierTemps(@ModelAttribute TempsTravail temps,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
    Utilisateur user = (Utilisateur) session.getAttribute("utilisateur");
    if (user == null) return "redirect:/login";

    temps.setMembreId(user.getId());
    temps.setDate(new Date());

    Tache tache = tacheService.findById(temps.getTacheId());

    if (temps.getDuree() > tache.getDureeEstimee()) {
        redirectAttributes.addFlashAttribute("info", "Durée modifiée mais dépasse la durée estimée !");
    } else {
        redirectAttributes.addFlashAttribute("info", "Temps modifié avec succès !");
    }

    tempsTravailService.update(temps);
    return "redirect:/membre/mesTaches";
}

}
