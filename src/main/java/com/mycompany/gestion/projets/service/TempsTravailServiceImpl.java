package com.mycompany.gestion.projets.service;

import com.mycompany.gestion.projets.model.TempsTravail;
import com.mycompany.gestion.projets.repository.TempsTravailRepository;
import java.util.List;

public class TempsTravailServiceImpl implements TempsTravailService {
    private final TempsTravailRepository repository;

    public TempsTravailServiceImpl(TempsTravailRepository repository) {
        this.repository = repository;
    }

    @Override
    public void enregistrerTemps(TempsTravail tempsTravail) {
        repository.save(tempsTravail);
    }

    @Override
    public List<TempsTravail> getTempsParMembre(int membreId) {
        return repository.findByMembreId(membreId);
    }
}
