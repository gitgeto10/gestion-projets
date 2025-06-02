package com.mycompany.gestion.projets.model;
import java.time.LocalDate;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Project {
    private int id;
    private String nom;
    private String description;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dateDebut;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date dateFin;
    private String statut;
    private int equipeId;
    private int chefProjetId;

    // Constructeurs
    public Project() {
    }

    public Project(String nom, String description, Date dateDebut, Date dateFin,
                   String statut, int equipeId, int chefProjetId) {
        this.nom = nom;
        this.description = description;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
        this.statut = statut;
        this.equipeId = equipeId;
        this.chefProjetId = chefProjetId;
    }

    // Getters et Setters
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(Date dateDebut) {
        this.dateDebut = dateDebut;
    }

    public Date getDateFin() {
        return dateFin;
    }

    public void setDateFin(Date dateFin) {
        this.dateFin = dateFin;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }

    public int getEquipeId() {
        return equipeId;
    }

    public void setEquipeId(int equipeId) {
        this.equipeId = equipeId;
    }

    public int getChefProjetId() {
        return chefProjetId;
    }

    public void setChefProjetId(int chefProjetId) {
        this.chefProjetId = chefProjetId;
    }

    @Override
    public String toString() {
        return "Project{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", description='" + description + '\'' +
                ", dateDebut=" + dateDebut +
                ", dateFin=" + dateFin +
                ", statut='" + statut + '\'' +
                ", equipeId=" + equipeId +
                ", chefProjetId=" + chefProjetId +
                '}';
    }
}