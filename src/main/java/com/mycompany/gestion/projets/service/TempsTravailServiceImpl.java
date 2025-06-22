package com.mycompany.gestion.projets.service;

import com.mycompany.gestion.projets.model.TempsTravail;
import com.mycompany.gestion.projets.repository.TempsTravailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TempsTravailServiceImpl implements TempsTravailService {

    @Autowired
    private TempsTravailRepository tempsTravailRepository;

    @Override
    public boolean save(TempsTravail tempsTravail) {
        return tempsTravailRepository.save(tempsTravail);
    }

    @Override
    public List<TempsTravail> findByMembreId(int membreId) {
        return tempsTravailRepository.findByMembreId(membreId);
    }
    @Override
    public TempsTravail findByTacheIdAndMembreId(int tacheId, int membreId) {
        return tempsTravailRepository.findByTacheIdAndMembreId(tacheId, membreId);
    }
    @Override
    public boolean update(TempsTravail tempsTravail) {
        return tempsTravailRepository.update(tempsTravail);
    }
}
