package com.mycompany.gestion.projets.service;

import com.mycompany.gestion.projets.model.Tache;
import com.mycompany.gestion.projets.repository.TacheRepository;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

@Service
public class TacheServiceImpl implements TacheService {

    private TacheRepository tacheRepository;

    @PostConstruct
    public void init() {
        try {
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/gestion_projets", "root", "");
            tacheRepository = new TacheRepository(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Tache> findAll() {
        return tacheRepository.findAll();
    }

    @Override
    public Tache findById(int id) {
        return tacheRepository.findById(id);
    }

    @Override
    public Tache findByName(String name) {
        return tacheRepository.findByName(name);
    }

    @Override
    public List<Tache> findByProjetId(int projetId) {
        return tacheRepository.findByProjetId(projetId);
    }

    @Override
    public List<Tache> findByMembreId(int membreId) {
        return tacheRepository.findByMembreId(membreId);
    }

    @Override
    public List<Tache> findByEtat(String etat) {
        return tacheRepository.findByEtat(etat);
    }

    @Override
    public List<Tache> findByProjetIdAndEtat(int projetId, String etat) {
        return tacheRepository.findByProjetIdAndEtat(projetId, etat);
    }

    @Override
    public List<Tache> findTachesNonAssignees() {
        return tacheRepository.findTachesNonAssignees();
    }

    @Override
    public boolean save(Tache tache) {
        return tacheRepository.save(tache);
    }

    @Override
    public boolean delete(int id) {
        return tacheRepository.delete(id);
    }

    @Override
    public int countTaches() {
        return tacheRepository.countTaches();
    }

    @Override
    public int countTachesByProjet(int projetId) {
        return tacheRepository.countTachesByProjet(projetId);
    }

    @Override
    public int countTachesByEtat(String etat) {
        return tacheRepository.countTachesByEtat(etat);
    }
}