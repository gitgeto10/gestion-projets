package com.mycompany.gestion.projets.service;

import com.mycompany.gestion.projets.model.Project;
import java.util.List;

public interface ProjectService {
    List<Project> findAll();
    Project findById(int id);
    Project findByName(String name);
    List<Project> findByEquipeId(int equipeId);
    List<Project> findByChefProjetId(int chefProjetId);
    boolean save(Project project);
    boolean delete(int id);
    int countProjects();
}