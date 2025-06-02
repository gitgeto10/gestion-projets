package com.mycompany.gestion.projets.service;

import com.mycompany.gestion.projets.model.Project;
import com.mycompany.gestion.projets.repository.ProjectRepository;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

@Service
public class ProjectServiceImpl implements ProjectService {

    private ProjectRepository projectRepository;

    @PostConstruct
    public void init() {
        try {
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/gestion_projets", "root", "");
            projectRepository = new ProjectRepository(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Project> findAll() {
        return projectRepository.findAll();
    }

    @Override
    public Project findById(int id) {
        return projectRepository.findById(id);
    }

    @Override
    public Project findByName(String name) {
        return projectRepository.findByName(name);
    }

    @Override
    public List<Project> findByEquipeId(int equipeId) {
        return projectRepository.findByEquipeId(equipeId);
    }

    @Override
    public List<Project> findByChefProjetId(int chefProjetId) {
        return projectRepository.findByChefProjetId(chefProjetId);
    }

    @Override
    public boolean save(Project project) {
        return projectRepository.save(project);
    }

    @Override
    public boolean delete(int id) {
        return projectRepository.delete(id);
    }

    @Override
    public int countProjects() {
        return projectRepository.countProjects();
    }
}