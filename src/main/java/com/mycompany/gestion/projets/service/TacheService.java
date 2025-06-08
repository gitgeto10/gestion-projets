package com.mycompany.gestion.projets.service;

import com.mycompany.gestion.projets.model.Tache;
import java.util.List;

public interface TacheService {
    List<Tache> findAll();
    Tache findById(int id);
    Tache findByName(String name);
    List<Tache> findByProjetId(int projetId);
    List<Tache> findByMembreId(int membreId);
    List<Tache> findByEtat(String etat);
    List<Tache> findByProjetIdAndEtat(int projetId, String etat);
    List<Tache> findTachesNonAssignees();
    boolean save(Tache tache);
    boolean delete(int id);
    int countTaches();
    int countTachesByProjet(int projetId);
    int countTachesByEtat(String etat);
}