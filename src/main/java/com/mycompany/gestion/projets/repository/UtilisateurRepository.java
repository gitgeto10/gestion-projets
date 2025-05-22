package com.mycompany.gestion.projets.repository;

import com.mycompany.gestion.projets.model.Utilisateur;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;

public class UtilisateurRepository {
    private final Connection connection;

    public UtilisateurRepository(Connection connection) {
        this.connection = connection;
    }

    public Utilisateur findByEmail(String email) {
        try {
            String sql = "SELECT * FROM utilisateur WHERE email = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Utilisateur user = new Utilisateur();
                user.setId(rs.getInt("id"));
                user.setNom(rs.getString("nom"));
                user.setEmail(rs.getString("email"));
                user.setPwd(rs.getString("pwd"));
                user.setRole(rs.getString("role"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public List<Utilisateur> findAll() {
        List<Utilisateur> utilisateurs = new ArrayList<>();
        try {
            String sql = "SELECT * FROM utilisateur";
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Utilisateur user = new Utilisateur();
                user.setId(rs.getInt("id"));
                user.setNom(rs.getString("nom"));
                user.setEmail(rs.getString("email"));
                user.setPwd(rs.getString("pwd"));
                user.setRole(rs.getString("role"));
                utilisateurs.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return utilisateurs;
    }
     public Utilisateur findById(int id) {
        try {
            String sql = "SELECT * FROM utilisateur WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Utilisateur user = new Utilisateur();
                user.setId(rs.getInt("id"));
                user.setNom(rs.getString("nom"));
                user.setEmail(rs.getString("email"));
                user.setPwd(rs.getString("pwd"));
                user.setRole(rs.getString("role"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean save(Utilisateur utilisateur) {
    try {
        if (utilisateur.getId() > 0) {
            // Modifier
            String hashedPwd = BCrypt.hashpw(utilisateur.getPwd(), BCrypt.gensalt());
            utilisateur.setPwd(hashedPwd); // mise à jour de l'objet avec mot de passe hashé

            String sql = "UPDATE utilisateur SET nom = ?, email = ?, pwd = ?, role = ? WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, utilisateur.getNom());
            stmt.setString(2, utilisateur.getEmail());
            stmt.setString(3, utilisateur.getPwd()); // maintenant hashé
            stmt.setString(4, utilisateur.getRole());
            stmt.setInt(5, utilisateur.getId());
            stmt.executeUpdate();
        } else {
            // Insertion
            String hashedPwd = BCrypt.hashpw(utilisateur.getPwd(), BCrypt.gensalt());
            utilisateur.setPwd(hashedPwd); // mise à jour de l'objet

            String sql = "INSERT INTO utilisateur (nom, email, pwd, role) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, utilisateur.getNom());
            stmt.setString(2, utilisateur.getEmail());
            stmt.setString(3, utilisateur.getPwd()); // maintenant hashé
            stmt.setString(4, utilisateur.getRole());
            stmt.executeUpdate();
        }
        return true;
    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    } 
}

public int countUtilisateurs() {
    int count = 0;
    try {
        String sql = "SELECT COUNT(*) AS total FROM utilisateur";
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
            String sql = "DELETE FROM utilisateur WHERE id = ?";
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
