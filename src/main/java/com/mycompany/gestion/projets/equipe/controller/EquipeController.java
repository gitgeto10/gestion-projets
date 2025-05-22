package com.mycompany.gestion.projets.equipe.controller;

import com.mycompany.gestion.projets.equipe.model.Equipe;
import com.mycompany.gestion.projets.equipe.service.EquipeService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/equipes")
public class EquipeController {

    private final EquipeService equipeService;

    public EquipeController(EquipeService equipeService) {
        this.equipeService = equipeService;
    }

    @GetMapping
    public List<Equipe> getEquipes() {
        return equipeService.getAllEquipes();
    }

    @PostMapping
    public Equipe createEquipe(@RequestBody Equipe equipe) {
        return equipeService.addEquipe(equipe);
    }
}
