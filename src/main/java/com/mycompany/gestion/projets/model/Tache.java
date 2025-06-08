package com.mycompany.gestion.projets.model;

public class Tache {
    private int id;
    private String nom;
    private Integer dureeEstimee;
    private String etat;
    private Integer projetId;
    private Integer membreId;

    // Constructeur par défaut
    public Tache() {
    }

    // Constructeur avec paramètres
    public Tache(String nom, Integer dureeEstimee, String etat, Integer projetId, Integer membreId) {
        this.nom = nom;
        this.dureeEstimee = dureeEstimee;
        this.etat = etat;
        this.projetId = projetId;
        this.membreId = membreId;
    }

    // Constructeur complet
    public Tache(int id, String nom, Integer dureeEstimee, String etat, Integer projetId, Integer membreId) {
        this.id = id;
        this.nom = nom;
        this.dureeEstimee = dureeEstimee;
        this.etat = etat;
        this.projetId = projetId;
        this.membreId = membreId;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getNom() {
        return nom;
    }

    public Integer getDureeEstimee() {
        return dureeEstimee;
    }

    public String getEtat() {
        return etat;
    }

    public Integer getProjetId() {
        return projetId;
    }

    public Integer getMembreId() {
        return membreId;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setDureeEstimee(Integer dureeEstimee) {
        this.dureeEstimee = dureeEstimee;
    }

    public void setEtat(String etat) {
        this.etat = etat;
    }

    public void setProjetId(Integer projetId) {
        this.projetId = projetId;
    }

    public void setMembreId(Integer membreId) {
        this.membreId = membreId;
    }

    // Méthodes utilitaires
    @Override
    public String toString() {
        return "Tache{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", dureeEstimee=" + dureeEstimee +
                ", etat='" + etat + '\'' +
                ", projetId=" + projetId +
                ", membreId=" + membreId +
                '}';
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;

        Tache tache = (Tache) obj;
        return id == tache.id;
    }

    @Override
    public int hashCode() {
        return Integer.hashCode(id);
    }

    // Méthodes métier
    public boolean estTerminee() {
        return "Terminé".equalsIgnoreCase(etat) || "Terminée".equalsIgnoreCase(etat);
    }

    public boolean estEnCours() {
        return "En cours".equalsIgnoreCase(etat);
    }

    public boolean estNonCommencee() {
        return "Non commencée".equalsIgnoreCase(etat) || "À faire".equalsIgnoreCase(etat);
    }

    public void marquerCommeTerminee() {
        this.etat = "Terminée";
    }

    public void demarrer() {
        this.etat = "En cours";
    }

    public boolean aUnMembre() {
        return membreId != null;
    }

    public boolean appartientAuProjet(int projetId) {
        return this.projetId != null && this.projetId == projetId;
    }
}
