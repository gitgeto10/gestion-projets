package com.mycompany.gestion.projets.service;

import com.mycompany.gestion.projets.model.Equipe;
import com.mycompany.gestion.projets.repository.EquipeRepository;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

@Service
public class EquipeServiceImpl implements EquipeService {

    private EquipeRepository equipeRepository;

    @PostConstruct
    public void init() {
        try {
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/gestion_projets", "root", "");
            equipeRepository = new EquipeRepository(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Equipe> findAll() {
        return equipeRepository.findAll();
    }
    @Override
    public Equipe findById(int id) {
        return equipeRepository.findById(id);
    }

    @Override
    public boolean save(Equipe equipe) {
        return equipeRepository.save(equipe);
    }

    @Override
    public boolean delete(int id) {
        return equipeRepository.delete(id);
    }
    @Override
    public int countEquipes() {
        return equipeRepository.countEquipes();
    }


}
