package com.mycompany.gestion.projets.repository;

import com.mycompany.gestion.projets.model.Livrable;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class LivrableRepository {

    private final DataSource dataSource;

    public LivrableRepository(DataSource dataSource) {
        this.dataSource = dataSource;
    }
public Livrable findById(int id) throws SQLException {
    String sql = "SELECT * FROM livrable WHERE id = ?";
    try (Connection conn = dataSource.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            Livrable l = new Livrable();
            l.setId(rs.getInt("id"));
            l.setNom(rs.getString("nom"));
            l.setFichierNom(rs.getString("fichier"));
            l.setDateDepot(rs.getDate("dateDepot"));
            l.setTacheId(rs.getInt("tache_id"));
            return l;
        }
    }

    return null;
}

    public List<Livrable> findAllByUserId(int userId) throws SQLException {
        String sql = "SELECT l.* FROM livrable l JOIN tache t ON l.tache_id = t.id WHERE t.membre_id = ?";
        List<Livrable> livrables = new ArrayList<>();

        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Livrable l = new Livrable();
                l.setId(rs.getInt("id"));
                l.setNom(rs.getString("nom"));
                l.setFichierNom(rs.getString("fichier"));
                l.setDateDepot(rs.getDate("dateDepot"));
                l.setTacheId(rs.getInt("tache_id"));
                livrables.add(l);
            }
        }

        return livrables;
    }

    public void save(Livrable livrable) throws SQLException {
        String sql = "INSERT INTO livrable (nom, fichier, dateDepot, tache_id) VALUES (?, ?, ?, ?)";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, livrable.getNom());
            stmt.setString(2, livrable.getFichierNom());
            stmt.setDate(3, livrable.getDateDepot());
            stmt.setInt(4, livrable.getTacheId());

            stmt.executeUpdate();
        }
    }
    public void update(Livrable livrable) throws SQLException {
    String sql = "UPDATE livrable SET nom = ?, fichier = ?, dateDepot = ? WHERE id = ?";
    try (Connection conn = dataSource.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, livrable.getNom());
        stmt.setString(2, livrable.getFichierNom());
        stmt.setDate(3, livrable.getDateDepot());
        stmt.setInt(4, livrable.getId());

        stmt.executeUpdate();
    }
}

}
