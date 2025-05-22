package com.mycompany.gestion.projets.service;

import com.mycompany.gestion.projets.model.Utilisateur;
import java.util.List;

public interface UtilisateurService {
    Utilisateur login(String email, String pwd);
    List<Utilisateur> findAll();
    Utilisateur findById(int id);
    boolean save(Utilisateur utilisateur);
    boolean delete(int id);
    int countUtilisateurs();

}
