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
import java.util.List;
import java.util.UUID;

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
    public Devoir recupererDevoir(Long userId, UUID courseId, String idDevoir) throws DevoirNotFoundException, IllegalAccessError{
        if(!verifierAutorisation(userId,courseId)){
            throw new IllegalAccessError("You cannot perform this action");
        }
        Devoir devoir = devoirRepository.findById(idDevoir).orElseThrow(()->new DevoirNotFoundException("Devoir introuvable"));


        return devoir;
    }

    /**
     * Fonction pour récupérer tout les devoirs
     */
    public List<Devoir> recupererDevoirs(Long userId, UUID courseId) throws IllegalAccessError{
        if(!verifierAutorisation(userId,courseId)){
            throw new IllegalAccessError("You cannot perform this action");
        }
        List<Devoir> devoirs = devoirRepository.findDevoirsByIdCours(courseId);
        return devoirs;
    }

    /**
     * Fonction ajouter un devoir et ses informations
     */
    public Devoir addDevoir(Long userId, UUID courseId, DevoirDTO devoirDTO) throws IllegalAccessError {
        Devoir devoir = new Devoir();
        if(!verifierAutorisation(userId,devoir.getIdCours())){
            throw new IllegalAccessError("You cannot perform this action");
        }

        DevoirInfos devoirInfos = new DevoirInfos();
        devoirInfos.setContenu(devoirDTO.getContenu());

        devoir.setIdCours(courseId);
        devoir.setType(devoirDTO.getType());
        devoir.setIdProprietaire(devoirDTO.getIdProprietaire());
        devoir.setDevoirInfos(devoirInfos);
        devoir.setReponses(new ArrayList<>());

        devoirInfosRepository.save(devoirInfos);
        devoir = devoirRepository.save(devoir);

        //return devoir.getId();
        return devoir;
    }

    /**
     * Fonction pour rendre un devoir
     */
    public DevoirReponse rendreDevoir(Long userId, UUID courseId, String idDevoir, DevoirReponseDTO devoirReponseDTO) throws DevoirNotFoundException,IllegalAccessError{
        if(!verifierAutorisation(userId,courseId)){
            throw new IllegalAccessError("You cannot perform this action");
        }
        Devoir devoir = devoirRepository.findById(idDevoir).orElseThrow(()->new DevoirNotFoundException("Devoir introuvable"));


        DevoirReponse devoirReponse = new DevoirReponse();

        Fichier f = new Fichier();
        f.setNom(devoirReponseDTO.getNomFichier());



        devoir.getReponses().add(devoirReponse);

        devoirReponse.setFichier(f);
        devoirReponse.setIdProprietaire(devoirReponseDTO.getIdProprietaire());
        devoirReponse.setNote(0);

        fichierRepository.save(f);
        devoirReponseRepository.save(devoirReponse);
        devoirRepository.save(devoir);

        return devoirReponse;
    }

    /**
     * Fonction pour noter un devoir
     */
    public DevoirReponse noterDevoir(Long userId, UUID courseId, String idDevoir, String idReponse, NoteDTO noteDTO) throws DevoirNotFoundException, IllegalAccessError, RenduNotFoundException {
        if(!verifierAutorisation(userId,courseId)){
            throw new IllegalAccessError("You cannot perform this action");
        }
        Devoir devoir = devoirRepository.findById(idDevoir).orElseThrow(()->new DevoirNotFoundException("Devoir introuvable"));

        DevoirReponse devoirReponse =  devoir.getReponses().stream().filter(reponse -> idReponse.equals(reponse.getId())).findFirst().orElseThrow(()->new RenduNotFoundException("Rendu introuvable"));
        devoirReponse.setNote(noteDTO.getNote());
        devoirReponseRepository.save(devoirReponse);

        return devoirReponse;
    }

    private boolean verifierAutorisation(Long userId,UUID courseId){
        // TODO Contacter l'api cours pour vérifier autorisation
        return true;
    }
}
