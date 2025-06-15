/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.gestion.projets.model;

import java.sql.Date;

public class TempsTravail {
    private int id;
    private int duree;
    private Date date;
    private int membreId;
    private int tacheId;

    // Getters et Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getDuree() { return duree; }
    public void setDuree(int duree) { this.duree = duree; }

    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }

    public int getMembreId() { return membreId; }
    public void setMembreId(int membreId) { this.membreId = membreId; }

    public int getTacheId() { return tacheId; }
    public void setTacheId(int tacheId) { this.tacheId = tacheId; }
}
