package com.mycompany.gestion.projets.repository;

import com.mycompany.gestion.projets.model.Equipe;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;

public class EquipeRepository {
    private final Connection connection;

    public EquipeRepository(Connection connection) {
        this.connection = connection;
    }

    public Equipe findByName(String name) {
        try {
            String sql = "SELECT * FROM equipe WHERE nom = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Equipe equipe = new Equipe();
                equipe.setId(rs.getInt("id"));
                equipe.setNom(rs.getString("nom"));
                return equipe;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public List<Equipe> findAll() {
        List<Equipe> Equipes = new ArrayList<>();
        try {
            String sql = "SELECT * FROM equipe";
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Equipe equipe = new Equipe();
                equipe.setId(rs.getInt("id"));
                equipe.setNom(rs.getString("nom"));
                Equipes.add(equipe);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Equipes;
    }
    public Equipe findById(int id) {
        try {
            String sql = "SELECT * FROM equipe WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Equipe equipe = new Equipe();
                equipe.setId(rs.getInt("id"));
                equipe.setNom(rs.getString("nom"));
                return equipe;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean save(Equipe equipe) {
        try {
            if (equipe.getId() > 0) {
                // Modifier

                String sql = "UPDATE equipe SET nom = ? WHERE id = ?";
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.setString(1, equipe.getNom());
                stmt.setInt(2, equipe.getId());
                stmt.executeUpdate();
            } else {
                // Insertion

                String sql = "INSERT INTO equipe (nom) VALUES (?)";
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.setString(1, equipe.getNom());
                stmt.executeUpdate();
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int countEquipes() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) AS total FROM equipe";
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

    public boolean delete(int id) {
        try {
            String sql = "DELETE FROM equipe WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
