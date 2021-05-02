package com.inpt.lms.servicedevoirs.service;

import com.inpt.lms.servicedevoirs.dto.DevoirDTO;
import com.inpt.lms.servicedevoirs.dto.DevoirReponseDTO;
import com.inpt.lms.servicedevoirs.dto.NoteDTO;
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

@Service
@AllArgsConstructor
public class DevoirService {
    private final DevoirRepository devoirRepository;
    private final DevoirInfosRepository devoirInfosRepository;
    private final DevoirReponseRepository devoirReponseRepository;
    private final FichierRepository fichierRepository;


    /**
     * Fonction pour récupérer un devoir
     * @return
     */
    public Devoir recupererDevoir(String idDevoir){
        // TODO A proper error here
        Devoir devoir = devoirRepository.findById(idDevoir).orElseThrow(()->new RuntimeException());
        return devoir;
    }

    /**
     * Fonction pour récupérer tout les devoirs
     * @return
     */
    public List<Devoir> recupererDevoirs(){
        List<Devoir> devoirs = devoirRepository.findAll();
        return devoirs;
    }

    /**
     * Fonction ajouter un devoir et ses informations
     * @return
     */
    public String addDevoir(DevoirDTO devoirDTO){
        Devoir devoir = new Devoir();

        DevoirInfos devoirInfos = new DevoirInfos();
        devoirInfos.setContenu(devoirDTO.getContenu());

        devoir.setIdCours(devoirDTO.getIdCours());
        devoir.setType(devoirDTO.getType());
        devoir.setIdProprietaire(devoirDTO.getIdProprietaire());
        devoir.setDevoirInfos(devoirInfos);
        devoir.setReponses(new ArrayList<>());

        devoirInfosRepository.save(devoirInfos);
        devoir = devoirRepository.save(devoir);

        return devoir.getId();
    }

    /**
     * Fonction pour rendre un devoir
     */
    public DevoirReponse rendreDevoir(String idDevoir, DevoirReponseDTO devoirReponseDTO){
        DevoirReponse devoirReponse = new DevoirReponse();

        Fichier f = new Fichier();
        f.setNom(devoirReponseDTO.getNomFichier());


        // TODO A proper error here
        Devoir devoir = devoirRepository.findById(idDevoir).orElseThrow(()->new RuntimeException());

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
    public DevoirReponse noterDevoir(String idDevoir, String idReponse, NoteDTO note){
        Devoir devoir = devoirRepository.findById(idDevoir).orElseThrow(()->new RuntimeException());
        // TODO A proper error here
        DevoirReponse devoirReponse =  devoir.getReponses().stream().filter(reponse -> idReponse.equals(reponse.getId())).findFirst().orElseThrow(()->new RuntimeException());
        devoirReponse.setNote(note.getNote());
        devoirReponseRepository.save(devoirReponse);

        return devoirReponse;
    }

    private boolean verifierAutorisation(String idUser,String idCours){
        // TODO Contacter l'api cours pour vérifier autorisation
        return true;
    }
}
