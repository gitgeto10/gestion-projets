package com.mycompany.gestion.projets.repository;

import com.mycompany.gestion.projets.model.Tache;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TacheRepository {
    private final Connection connection;

    public TacheRepository(Connection connection) {
        this.connection = connection;
    }

    public Tache findByName(String name) {
        try {
            String sql = "SELECT * FROM tache WHERE nom = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, name);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToTache(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Tache> findAll() {
        List<Tache> taches = new ArrayList<>();
        try {
            String sql = "SELECT * FROM tache";
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                taches.add(mapResultSetToTache(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return taches;
    }

    public Tache findById(int id) {
        try {
            String sql = "SELECT * FROM tache WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToTache(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Tache> findByProjetId(int projetId) {
        List<Tache> taches = new ArrayList<>();
        try {
            String sql = "SELECT * FROM tache WHERE projet_id = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, projetId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                taches.add(mapResultSetToTache(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return taches;
    }

    public List<Tache> findByMembreId(int membreId) {
        List<Tache> taches = new ArrayList<>();
        try {
            String sql = "SELECT * FROM tache WHERE membre_id = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, membreId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                taches.add(mapResultSetToTache(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return taches;
    }

    public List<Tache> findByEtat(String etat) {
        List<Tache> taches = new ArrayList<>();
        try {
            String sql = "SELECT * FROM tache WHERE etat = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, etat);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                taches.add(mapResultSetToTache(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return taches;
    }

    public List<Tache> findByProjetIdAndEtat(int projetId, String etat) {
        List<Tache> taches = new ArrayList<>();
        try {
            String sql = "SELECT * FROM tache WHERE projet_id = ? AND etat = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, projetId);
            stmt.setString(2, etat);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                taches.add(mapResultSetToTache(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return taches;
    }

    public List<Tache> findTachesNonAssignees() {
        List<Tache> taches = new ArrayList<>();
        try {
            String sql = "SELECT * FROM tache WHERE membre_id IS NULL";
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                taches.add(mapResultSetToTache(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return taches;
    }

    public boolean save(Tache tache) {
        try {
            if (tache.getId() > 0) {
                // Modifier
                String sql = "UPDATE tache SET nom = ?, dureeEstimee = ?, etat = ?, projet_id = ?, membre_id = ? WHERE id = ?";
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.setString(1, tache.getNom());
                setIntegerOrNull(stmt, 2, tache.getDureeEstimee());
                stmt.setString(3, tache.getEtat());
                setIntegerOrNull(stmt, 4, tache.getProjetId());
                setIntegerOrNull(stmt, 5, tache.getMembreId());
                stmt.setInt(6, tache.getId());
                stmt.executeUpdate();
            } else {
                // Insertion
                String sql = "INSERT INTO tache (nom, dureeEstimee, etat, projet_id, membre_id) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement stmt = connection.prepareStatement(sql);
                stmt.setString(1, tache.getNom());
                setIntegerOrNull(stmt, 2, tache.getDureeEstimee());
                stmt.setString(3, tache.getEtat());
                setIntegerOrNull(stmt, 4, tache.getProjetId());
                setIntegerOrNull(stmt, 5, tache.getMembreId());
                stmt.executeUpdate();
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int countTaches() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) AS total FROM tache";
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
        String sql = "SELECT COUNT(*) FROM tache WHERE utilisateur_id = ?";
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
    public int countTachesByProjet(int projetId) {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) AS total FROM tache WHERE projet_id = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, projetId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public int countTachesByEtat(String etat) {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) AS total FROM tache WHERE etat = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, etat);
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
            String sql = "DELETE FROM tache WHERE id = ?";
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Méthode utilitaire pour mapper ResultSet vers Tache
    private Tache mapResultSetToTache(ResultSet rs) throws SQLException {
        Tache tache = new Tache();
        tache.setId(rs.getInt("id"));
        tache.setNom(rs.getString("nom"));

        // Gestion des valeurs nullable
        int dureeEstimee = rs.getInt("dureeEstimee");
        if (!rs.wasNull()) {
            tache.setDureeEstimee(dureeEstimee);
        }

        tache.setEtat(rs.getString("etat"));

        int projetId = rs.getInt("projet_id");
        if (!rs.wasNull()) {
            tache.setProjetId(projetId);
        }

        int membreId = rs.getInt("membre_id");
        if (!rs.wasNull()) {
            tache.setMembreId(membreId);
        }

        return tache;
    }

    // Méthode utilitaire pour gérer les valeurs Integer nullable
    private void setIntegerOrNull(PreparedStatement stmt, int parameterIndex, Integer value) throws SQLException {
        if (value != null) {
            stmt.setInt(parameterIndex, value);
        } else {
            stmt.setNull(parameterIndex, Types.INTEGER);
        }
    }
public List<Tache> findTachesPourMembre(int membreId) {
    List<Tache> taches = new ArrayList<>();
String sql =
    "SELECT t.id, t.nom, t.dureeEstimee, t.etat, t.membre_id, p.nom AS nom_projet, l.id AS livrable_id " +
    "FROM tache t " +
    "JOIN projet p ON t.projet_id = p.id " +
    "LEFT JOIN livrable l ON l.tache_id = t.id " +
    "WHERE t.membre_id = ? " +
    "GROUP BY t.id, t.nom, t.dureeEstimee, t.etat, t.membre_id, p.nom, l.id";


    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setInt(1, membreId);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            Tache tache = new Tache();
            tache.setId(rs.getInt("id"));
            tache.setNom(rs.getString("nom"));
            tache.setDureeEstimee(rs.getInt("dureeEstimee"));
            tache.setEtat(rs.getString("etat"));
            tache.setMembreId(rs.getInt("membre_id"));
            tache.setProjetNom(rs.getString("nom_projet"));

            int livrableId = rs.getInt("livrable_id");
            if (!rs.wasNull()) {
                tache.setLivrableId(livrableId);
            } else {
                tache.setLivrableId(null); // important
            }

            taches.add(tache);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return taches;
}
}