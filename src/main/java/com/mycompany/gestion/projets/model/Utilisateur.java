package com.mycompany.gestion.projets.model;

public class Utilisateur {
    private int id;
    private String nom;
    private String email;
    private String pwd;
    private String role;

    // Getters et Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPwd() { return pwd; }
    public void setPwd(String pwd) { this.pwd = pwd; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}
