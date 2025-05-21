package com.mycompany.gestion.projets.equipe.repository;

import com.mycompany.gestion.projets.equipe.model.Equipe;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EquipeRepository extends JpaRepository<Equipe, Long> {
}