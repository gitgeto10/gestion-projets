package com.mycompany.gestion.projets.service;

import com.mycompany.gestion.projets.model.TempsTravail;
import java.util.List;

public interface TempsTravailService {
    boolean save(TempsTravail tempsTravail);
    List<TempsTravail> findByMembreId(int membreId);
    TempsTravail findByTacheIdAndMembreId(int tacheId, int membreId);
    boolean update(TempsTravail tempsTravail);

}
