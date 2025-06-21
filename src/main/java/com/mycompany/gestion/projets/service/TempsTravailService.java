package com.mycompany.gestion.projets.service;

import com.mycompany.gestion.projets.model.TempsTravail;
import java.util.List;

public interface TempsTravailService {
    void enregistrerTemps(TempsTravail tempsTravail);
    List<TempsTravail> getTempsParMembre(int membreId);
}
