package com.mycompany.gestion.projets.service;

import com.mycompany.gestion.projets.model.Livrable;
import com.mycompany.gestion.projets.repository.LivrableRepository;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

@Service
public class LivrableServiceImpl implements LivrableService {

    private final LivrableRepository livrableRepository;

    public LivrableServiceImpl(LivrableRepository livrableRepository) {
        this.livrableRepository = livrableRepository;
    }

    @Override
    public void soumettreLivrable(Livrable livrable) {
        try {
            livrableRepository.save(livrable);
        } catch (SQLException e) {
            e.printStackTrace();
            // Tu peux gérer une exception custom ou logger ici
        }
    }

    @Override
    public List<Livrable> getLivrablesByUserId(int userId) {
        try {
            return livrableRepository.findAllByUserId(userId);
        } catch (SQLException e) {
            e.printStackTrace();
            return Collections.emptyList();
        }
    }
    @Override
    public void modifierLivrable(Livrable livrable) {
    try {
        livrableRepository.update(livrable);
    } catch (SQLException e) {
        e.printStackTrace(); // à remplacer par une vraie gestion d’erreur si besoin
    }
}
    @Override
    public Livrable getLivrableById(int id) {
    try {
        return livrableRepository.findById(id);
    } catch (SQLException e) {
        e.printStackTrace();
        return null;
    }
}
    @Override
    public List<Livrable> getLivrablesByTaches(List<Integer> tacheIds) throws SQLException {
        if (tacheIds == null || tacheIds.isEmpty()) {
            return Collections.emptyList();
        }
        return livrableRepository.findLivrablesByTaches(tacheIds);
    }
}
