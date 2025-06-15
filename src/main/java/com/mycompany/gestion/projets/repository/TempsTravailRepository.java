package com.mycompany.gestion.projets.repository;

import com.mycompany.gestion.projets.model.TempsTravail;
import java.util.List;

public interface TempsTravailRepository {
    void save(TempsTravail t);
    List<TempsTravail> findByMembreId(int membreId);
}
