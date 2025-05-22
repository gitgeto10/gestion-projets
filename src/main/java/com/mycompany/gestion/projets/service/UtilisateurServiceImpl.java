package com.mycompany.gestion.projets.service;

import com.mycompany.gestion.projets.model.Utilisateur;
import com.mycompany.gestion.projets.repository.UtilisateurRepository;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.List;

@Service
public class UtilisateurServiceImpl implements UtilisateurService {

    private UtilisateurRepository utilisateurRepository;

    @PostConstruct
    public void init() {
        try {
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/gestion_projets", "root", "");
            utilisateurRepository = new UtilisateurRepository(conn);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public Utilisateur login(String email, String pwd) {
        Utilisateur utilisateur = utilisateurRepository.findByEmail(email);

        if (utilisateur != null) {
            String hash = utilisateur.getPwd();
            System.out.println("Email reçu : " + email);
            System.out.println("Mot de passe reçu : [" + pwd + "]");
            System.out.println("Hash enregistré : " + hash);

            boolean isPasswordCorrect = BCrypt.checkpw(pwd, hash);
            System.out.println("Résultat BCrypt : " + isPasswordCorrect);

            if (isPasswordCorrect) {
                System.out.println("Connexion réussie !");
                return utilisateur;
            } else {
                System.out.println("Mot de passe incorrect !");
            }
        } else {
            System.out.println("Utilisateur introuvable !");
        }

        return null;
    }
    @Override
    public List<Utilisateur> findAll() {
        return utilisateurRepository.findAll();
    }
    @Override
    public Utilisateur findById(int id) {
        return utilisateurRepository.findById(id);
    }

    @Override
    public boolean save(Utilisateur utilisateur) {
        return utilisateurRepository.save(utilisateur);
    }

    @Override
    public boolean delete(int id) {
        return utilisateurRepository.delete(id);
    }
    @Override
    public int countUtilisateurs() {
        return utilisateurRepository.countUtilisateurs();
    }


}
