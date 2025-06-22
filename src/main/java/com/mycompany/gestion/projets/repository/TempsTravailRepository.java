package com.mycompany.gestion.projets.repository;

import com.mycompany.gestion.projets.model.TempsTravail;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Repository
public class TempsTravailRepository {

    private final DataSource dataSource;

    public TempsTravailRepository(DataSource dataSource) {
        this.dataSource = dataSource;
    }

public boolean save(TempsTravail tempsTravail) {
    String sql = "INSERT INTO temps_travail (duree, date, membre_id, tache_id) VALUES (?, ?, ?, ?)";

    try (Connection connection = dataSource.getConnection();
         PreparedStatement stmt = connection.prepareStatement(sql)) {

        stmt.setInt(1, tempsTravail.getDuree());
        stmt.setDate(2, new java.sql.Date(tempsTravail.getDate().getTime()));
        stmt.setInt(3, tempsTravail.getMembreId());
        stmt.setInt(4, tempsTravail.getTacheId());

        stmt.executeUpdate();
        return true;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}


public List<TempsTravail> findByMembreId(int membreId) {
    List<TempsTravail> list = new ArrayList<>();
    String sql = "SELECT * FROM temps_travail WHERE membre_id = ?";

    try (Connection connection = dataSource.getConnection();
         PreparedStatement stmt = connection.prepareStatement(sql)) {

        stmt.setInt(1, membreId);
        ResultSet rs = stmt.executeQuery();

        while (rs.next()) {
            TempsTravail t = new TempsTravail();
            t.setId(rs.getInt("id"));
            t.setDuree(rs.getInt("duree"));
            t.setDate(rs.getDate("date"));
            t.setMembreId(rs.getInt("membre_id"));
            t.setTacheId(rs.getInt("tache_id"));
            list.add(t);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return list;
}
public TempsTravail findByTacheIdAndMembreId(int tacheId, int membreId) {
    String sql = "SELECT * FROM temps_travail WHERE tache_id = ? AND membre_id = ?";

    try (Connection connection = dataSource.getConnection();
         PreparedStatement stmt = connection.prepareStatement(sql)) {

        stmt.setInt(1, tacheId);
        stmt.setInt(2, membreId);

        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            TempsTravail t = new TempsTravail();
            t.setId(rs.getInt("id"));
            t.setDuree(rs.getInt("duree"));
            t.setDate(rs.getDate("date"));
            t.setMembreId(rs.getInt("membre_id"));
            t.setTacheId(rs.getInt("tache_id"));
            return t;
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return null; // Aucun temps trouvé
}
public boolean update(TempsTravail tempsTravail) {
    String sql = "UPDATE temps_travail SET duree = ?, date = ? WHERE id = ?";

    try (Connection connection = dataSource.getConnection();
         PreparedStatement stmt = connection.prepareStatement(sql)) {

        stmt.setInt(1, tempsTravail.getDuree());
        stmt.setDate(2, new java.sql.Date(tempsTravail.getDate().getTime()));
        stmt.setInt(3, tempsTravail.getId());

        return stmt.executeUpdate() > 0;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}




}
