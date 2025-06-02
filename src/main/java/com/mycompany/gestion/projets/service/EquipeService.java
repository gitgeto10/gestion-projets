package com.mycompany.gestion.projets.service;

import com.mycompany.gestion.projets.model.Equipe;
import java.util.List;

public interface EquipeService {
    List<Equipe> findAll();
    Equipe findById(int id);
    boolean save(Equipe equipe);
    boolean delete(int id);
    int countEquipes();

}
