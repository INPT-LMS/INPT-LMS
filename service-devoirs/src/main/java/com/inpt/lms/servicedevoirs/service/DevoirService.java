package com.inpt.lms.servicedevoirs.service;

import com.inpt.lms.servicedevoirs.dto.DevoirDTO;
import com.inpt.lms.servicedevoirs.dto.DevoirReponseDTO;
import com.inpt.lms.servicedevoirs.dto.NoteDTO;
import com.inpt.lms.servicedevoirs.exception.DevoirNotFoundException;
import com.inpt.lms.servicedevoirs.exception.RenduNotFoundException;
import com.inpt.lms.servicedevoirs.model.Devoir;
import com.inpt.lms.servicedevoirs.model.DevoirInfos;
import com.inpt.lms.servicedevoirs.model.DevoirReponse;
import com.inpt.lms.servicedevoirs.model.Fichier;
import com.inpt.lms.servicedevoirs.repository.DevoirInfosRepository;
import com.inpt.lms.servicedevoirs.repository.DevoirReponseRepository;
import com.inpt.lms.servicedevoirs.repository.DevoirRepository;
import com.inpt.lms.servicedevoirs.repository.FichierRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class DevoirService {
    private final DevoirRepository devoirRepository;
    private final DevoirInfosRepository devoirInfosRepository;
    private final DevoirReponseRepository devoirReponseRepository;
    private final FichierRepository fichierRepository;


    /**
     * Fonction pour récupérer un devoir
     */
    public Devoir recupererDevoir(Long userId, String courseId, String idDevoir) throws DevoirNotFoundException, IllegalAccessError {
        if (!verifierAutorisation(userId, courseId)) {
            throw new IllegalAccessError("You cannot perform this action");
        }
        Devoir devoir = devoirRepository.findById(idDevoir).orElseThrow(() -> new DevoirNotFoundException("Devoir introuvable"));
        filtrerReponsesDevoir(devoir, userId);


        return devoir;
    }

    /**
     * Fonction pour récupérer tout les devoirs
     */
    public List<Devoir> recupererDevoirs(Long userId, String courseId) throws IllegalAccessError {
        if (!verifierAutorisation(userId, courseId)) {
            throw new IllegalAccessError("You cannot perform this action");
        }
        List<Devoir> devoirs = devoirRepository.findDevoirsByIdCours(courseId);
        devoirs = devoirs.stream().map(devoir -> filtrerReponsesDevoir(devoir, userId)).collect(Collectors.toList());
        return devoirs;
    }

    /**
     * Fonction ajouter un devoir et ses informations
     */
    public Devoir addDevoir(Long userId, String courseId, DevoirDTO devoirDTO) throws IllegalAccessError {
        Devoir devoir = new Devoir();
        if (!verifierAutorisation(userId, devoir.getIdCours())) {
            throw new IllegalAccessError("You cannot perform this action");
        }

        DevoirInfos devoirInfos = new DevoirInfos();
        devoirInfos.setContenu(devoirDTO.getContenu());
        devoirInfos.setDateCreation(new Date());

        devoir.setIdCours(courseId);
        devoir.setType(devoirDTO.getType());
        devoir.setIdProprietaire(userId);
        devoir.setDevoirInfos(devoirInfos);
        devoir.setReponses(new ArrayList<>());
        devoir.setDateLimite(devoirDTO.getDateLimite());

        devoirInfosRepository.save(devoirInfos);
        devoir = devoirRepository.save(devoir);

        return devoir;
    }

    /**
     * Fonction pour rendre un devoir
     */
    public DevoirReponse rendreDevoir(Long userId, String courseId, String idDevoir, DevoirReponseDTO devoirReponseDTO) throws DevoirNotFoundException, IllegalAccessError {
        if (!verifierAutorisation(userId, courseId)) {
            throw new IllegalAccessError("You cannot perform this action");
        }
        Devoir devoir = devoirRepository.findById(idDevoir).orElseThrow(() -> new DevoirNotFoundException("Devoir introuvable"));


        DevoirReponse devoirReponse = new DevoirReponse();

        Fichier f = new Fichier();
        f.setNom(devoirReponseDTO.getNomFichier());


        devoir.getReponses().add(devoirReponse);

        devoirReponse.setFichier(f);
        devoirReponse.setIdProprietaire(userId);
        devoirReponse.setNote(0);
        devoirReponse.setEstNote(false);

        fichierRepository.save(f);
        devoirReponseRepository.save(devoirReponse);
        devoirRepository.save(devoir);

        return devoirReponse;
    }

    /**
     * Fonction pour noter un devoir
     */
    public DevoirReponse noterDevoir(Long userId, String courseId, String idDevoir, String idReponse, NoteDTO noteDTO) throws DevoirNotFoundException, IllegalAccessError, RenduNotFoundException {
        if (!verifierAutorisation(userId, courseId)) {
            throw new IllegalAccessError("You cannot perform this action");
        }
        Devoir devoir = devoirRepository.findById(idDevoir).orElseThrow(() -> new DevoirNotFoundException("Devoir introuvable"));

        DevoirReponse devoirReponse = devoir.getReponses().stream().filter(reponse -> idReponse.equals(reponse.getId())).findFirst().orElseThrow(() -> new RenduNotFoundException("Rendu introuvable"));
        devoirReponse.setNote(noteDTO.getNote());
        devoirReponse.setEstNote(true);
        devoirReponseRepository.save(devoirReponse);
        devoirRepository.save(devoir);

        return devoirReponse;
    }

    private boolean verifierAutorisation(Long userId, String courseId) {
        // TODO Contacter l'api cours pour vérifier autorisation
        return true;
    }

    /**
     * Fonction pour filtrer les réponses d'un devoir en fonction de celui qui envoie la requete.
     * Si la requete est envoyée par le propriétaire du devoir, on affiche toutes les réponses.
     * Sinon, on n'affiche que la réponse de l'utilisateur authentifié
     */
    private Devoir filtrerReponsesDevoir(Devoir devoir, Long userId) {
        if (devoir.getIdProprietaire() == userId) {
            return devoir;
        }
        List<DevoirReponse> reponses = devoir.getReponses();
        reponses = reponses.stream().map(reponse -> reponse.getIdProprietaire() == userId ? reponse : null).filter(reponse -> reponse != null).collect(Collectors.toList());
        devoir.setReponses(reponses);

        return devoir;
    }
}
