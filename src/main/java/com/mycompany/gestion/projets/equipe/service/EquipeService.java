package com.mycompany.gestion.projets.equipe.service;

import com.mycompany.gestion.projets.equipe.model.Equipe;
import com.mycompany.gestion.projets.equipe.repository.EquipeRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EquipeService {

    private final EquipeRepository equipeRepository;

    public EquipeService(EquipeRepository equipeRepository) {
        this.equipeRepository = equipeRepository;
    }

    public List<Equipe> getAllEquipes() {
        return equipeRepository.findAll();
    }

    public Equipe addEquipe(Equipe equipe) {
        return equipeRepository.save(equipe);
    }
}
