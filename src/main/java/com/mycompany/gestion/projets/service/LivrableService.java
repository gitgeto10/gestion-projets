package com.mycompany.gestion.projets.service;

import com.mycompany.gestion.projets.model.Livrable;

import java.util.List;

public interface LivrableService {

    void soumettreLivrable(Livrable livrable);

    List<Livrable> getLivrablesByUserId(int userId);
    void modifierLivrable(Livrable livrable);
    Livrable getLivrableById(int id);
}
