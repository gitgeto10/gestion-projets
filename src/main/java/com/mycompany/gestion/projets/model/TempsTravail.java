package com.mycompany.gestion.projets.model;

import java.util.Date;

public class TempsTravail {
    private int id;
    private int duree; // en heures
    private Date date;
    private Integer membreId;
    private Integer tacheId;

    // Getters et Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getDuree() { return duree; }
    public void setDuree(int duree) { this.duree = duree; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public Integer getMembreId() { return membreId; }
    public void setMembreId(Integer membreId) { this.membreId = membreId; }

    public Integer getTacheId() { return tacheId; }
    public void setTacheId(Integer tacheId) { this.tacheId = tacheId; }
}
