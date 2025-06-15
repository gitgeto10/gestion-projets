package com.mycompany.gestion.projets.repository;

import com.mycompany.gestion.projets.model.Project;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjectRepository {
    private final Connection connection;

    public ProjectRepository(Connection connection) {
        this.connection = connection;
    }

    public Project findByName(String name) {
        try {
            String sql = "SELECT * FROM projet WHERE nom = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Project project = new Project();
                project.setId(rs.getInt("id"));
                project.setNom(rs.getString("nom"));
                project.setDescription(rs.getString("description"));
                project.setDateDebut(rs.getDate("dateDebut"));
                project.setDateFin(rs.getDate("dateFin"));
                project.setStatut(rs.getString("statut"));
                project.setEquipeId(rs.getInt("equipe_id"));
                project.setChefProjetId(rs.getInt("chef_projet_id"));
                return project;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Project> findAll() {
        List<Project> projects = new ArrayList<>();
        try {
            String sql = "SELECT * FROM projet";
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Project project = new Project();
                project.setId(rs.getInt("id"));
                project.setNom(rs.getString("nom"));
                project.setDescription(rs.getString("description"));
                project.setDateDebut(rs.getDate("dateDebut"));
                project.setDateFin(rs.getDate("dateFin"));
                project.setStatut(rs.getString("statut"));
                project.setEquipeId(rs.getInt("equipe_id"));
                project.setChefProjetId(rs.getInt("chef_projet_id"));
                projects.add(project);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projects;
    }

    public Project findById(int id) {
        try {
            String sql = "SELECT * FROM projet WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Project project = new Project();
                project.setId(rs.getInt("id"));
                project.setNom(rs.getString("nom"));
                project.setDescription(rs.getString("description"));
                project.setDateDebut(rs.getDate("dateDebut"));
                project.setDateFin(rs.getDate("dateFin"));
                project.setStatut(rs.getString("statut"));
                project.setEquipeId(rs.getInt("equipe_id"));
                project.setChefProjetId(rs.getInt("chef_projet_id"));
                return project;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Project> findByEquipeId(int equipeId) {
        List<Project> projects = new ArrayList<>();
        try {
            String sql = "SELECT * FROM projet WHERE equipe_id = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, equipeId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Project project = new Project();
                project.setId(rs.getInt("id"));
                project.setNom(rs.getString("nom"));
                project.setDescription(rs.getString("description"));
                project.setDateDebut(rs.getDate("dateDebut"));
                project.setDateFin(rs.getDate("dateFin"));
                project.setStatut(rs.getString("statut"));
                project.setEquipeId(rs.getInt("equipe_id"));
                project.setChefProjetId(rs.getInt("chef_projet_id"));
                projects.add(project);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projects;
    }

    public List<Project> findByChefProjetId(int chefProjetId) {
        List<Project> projects = new ArrayList<>();
        try {
            String sql = "SELECT * FROM projet WHERE chef_projet_id = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, chefProjetId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Project project = new Project();
                project.setId(rs.getInt("id"));
                project.setNom(rs.getString("nom"));
                project.setDescription(rs.getString("description"));
                project.setDateDebut(rs.getDate("dateDebut"));
                project.setDateFin(rs.getDate("dateFin"));
                project.setStatut(rs.getString("statut"));
                project.setEquipeId(rs.getInt("equipe_id"));
                project.setChefProjetId(rs.getInt("chef_projet_id"));
                projects.add(project);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return projects;
    }

    public boolean save(Project project) {
        try {
            if (project.getId() > 0) {
                // Modifier
                String sql = "UPDATE projet SET nom = ?, description = ?, dateDebut = ?, dateFin = ?, statut = ?, equipe_id = ?, chef_projet_id = ? WHERE id = ?";
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.setString(1, project.getNom());
                stmt.setString(2, project.getDescription());
                stmt.setDate(3, new java.sql.Date(project.getDateDebut().getTime()));
                stmt.setDate(4, new java.sql.Date(project.getDateFin().getTime()));
                stmt.setString(5, project.getStatut());
                stmt.setInt(6, project.getEquipeId());
                stmt.setInt(7, project.getChefProjetId());
                stmt.setInt(8, project.getId());
                stmt.executeUpdate();
            } else {
                // Insertion
                String sql = "INSERT INTO projet (nom, description, dateDebut, dateFin, statut, equipe_id, chef_projet_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.setString(1, project.getNom());
                stmt.setString(2, project.getDescription());
                stmt.setDate(3, new java.sql.Date(project.getDateDebut().getTime()));
                stmt.setDate(4, new java.sql.Date(project.getDateFin().getTime()));
                stmt.setString(5, project.getStatut());
                stmt.setInt(6, project.getEquipeId());
                stmt.setInt(7, project.getChefProjetId());
                stmt.executeUpdate();
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int countProjects() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) AS total FROM projet";
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
     public int countByUserId(int userId) {
        String sql = "SELECT COUNT(*) FROM projet_utilisateur WHERE utilisateur_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean delete(int id) {
        try {
            String sql = "DELETE FROM projet WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public int countProjetsByMembreId(int membreId) {
    int count = 0;
    try {
        String sql = "SELECT COUNT(DISTINCT projet_id) AS total FROM tache WHERE membre_id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, membreId);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            count = rs.getInt("total");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return count;
}
public List<Project> findByMembreId(int membreId) {
    List<Project> projects = new ArrayList<>();
    try {
        String sql = "SELECT p.* FROM projet p " +
                     "JOIN equipe e ON p.equipe_id = e.id " +
                     "JOIN utilisateur u ON e.id = u.equipe_id " +
                     "WHERE u.id = ?";
        PreparedStatement stmt = connection.prepareStatement(sql);
        stmt.setInt(1, membreId);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Project project = new Project();
            project.setId(rs.getInt("id"));
            project.setNom(rs.getString("nom"));
            project.setDescription(rs.getString("description"));
            project.setDateDebut(rs.getDate("dateDebut"));
            project.setDateFin(rs.getDate("dateFin"));
            project.setStatut(rs.getString("statut"));
            project.setEquipeId(rs.getInt("equipe_id"));
            project.setChefProjetId(rs.getInt("chef_projet_id"));
            projects.add(project);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return projects;
}
}