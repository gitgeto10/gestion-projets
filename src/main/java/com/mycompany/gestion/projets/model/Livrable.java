/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package com.mycompany.gestion.projets.model;

import java.sql.Date;

public class Livrable {
    private int id;
    private String nom;
    private String fichierNom;
    private Date dateDepot;
    private int tacheId;
    private String tacheNom;

    public Livrable() {}

    public Livrable(int id, String nom, String fichierNom, Date dateDepot, int tacheId, String tacheNom) {
        this.id = id;
        this.nom = nom;
        this.fichierNom = fichierNom;
        this.dateDepot = dateDepot;
        this.tacheId = tacheId;
        this.tacheNom = tacheNom;
    }

    // Getters et setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getFichierNom() {
        return fichierNom;
    }

    public void setFichierNom(String fichierNom) {
        this.fichierNom = fichierNom;
    }

    public Date getDateDepot() {
        return dateDepot;
    }

    public void setDateDepot(Date dateDepot) {
        this.dateDepot = dateDepot;
    }

    public int getTacheId() {
        return tacheId;
    }

    public void setTacheId(int tacheId) {
        this.tacheId = tacheId;
    }
    public String getTacheNom() { return tacheNom; }
    public void setTacheNom(String tacheNom) { this.tacheNom = tacheNom; }
}
