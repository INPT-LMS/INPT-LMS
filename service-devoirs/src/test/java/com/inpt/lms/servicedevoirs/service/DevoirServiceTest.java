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
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.ArrayList;
import java.util.Optional;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.*;

class DevoirServiceTest {
    private DevoirService underTest;

    @Mock
    private DevoirRepository devoirRepository;
    @Mock
    private DevoirInfosRepository devoirInfosRepository;
    @Mock
    private DevoirReponseRepository devoirReponseRepository;
    @Mock
    private FichierRepository fichierRepository;

    @BeforeEach
    void setUp(){
        MockitoAnnotations.openMocks(this);
        underTest = new DevoirService(devoirRepository,devoirInfosRepository,devoirReponseRepository,fichierRepository);
    }

    @Test
    @DisplayName("Doit récuperer un devoir existant")
    void doitRecupererUnDevoir() {
        String idDevoir = any();
        Devoir devoir = new Devoir();

        // Given
        given(devoirRepository.findById(idDevoir)).willReturn(Optional.of(devoir));

        // When
        underTest.recupererDevoir(idDevoir);

        // Then
        verify(devoirRepository).findById(idDevoir);
    }

    @Test
    @DisplayName("Doit récuperer tous les devoirs existants")
    void doitRecupererTousLesDevoirs() {
        // When
        underTest.recupererDevoirs();

        // Then
        verify(devoirRepository).findAll();
    }

    @Test
    @DisplayName("Doit ajouter un nouveau Devoir et DevoirInfos à partir du DevoirDTO")
    void doitAjouterUnNouveauDevoirEtDevoirInfosAPartirDuDTO() {
        // Given
        DevoirDTO devoirDTO = new DevoirDTO();
        devoirDTO.setIdProprietaire("X");
        devoirDTO.setIdCours("Y");
        devoirDTO.setContenu("Z");
        devoirDTO.setType("QUIZZ");

        DevoirInfos devoirInfos = new DevoirInfos();
        devoirInfos.setContenu(devoirDTO.getContenu());

        Devoir devoir = new Devoir();
        devoir.setIdCours(devoirDTO.getIdCours());
        devoir.setType(devoirDTO.getType());
        devoir.setIdProprietaire(devoirDTO.getIdProprietaire());
        devoir.setDevoirInfos(devoirInfos);
        devoir.setReponses(new ArrayList<>());
        devoir.setDevoirInfos(devoirInfos);

        // When
        underTest.addDevoir(devoirDTO);

        // Then
        ArgumentCaptor<Devoir> devoirArgumentCaptor = ArgumentCaptor.forClass(Devoir.class);
        ArgumentCaptor<DevoirInfos> devoirInfosArgumentCaptor= ArgumentCaptor.forClass(DevoirInfos.class);

        verify(devoirRepository).save(devoirArgumentCaptor.capture());
        verify(devoirInfosRepository).save(devoirInfosArgumentCaptor.capture());

        Devoir capturedDevoir = devoirArgumentCaptor.getValue();
        DevoirInfos capturedDevoirInfos = devoirInfosArgumentCaptor.getValue();

        assertThat(capturedDevoir).isEqualTo(devoir);
        assertThat(capturedDevoirInfos).isEqualTo(devoirInfos);
        assertThat(capturedDevoirInfos).isEqualTo(devoir.getDevoirInfos());
    }

    @Test
    @DisplayName("Doit rendre un devoir")
    void doitRendreUnDevoir() {
       // Given
        String idDevoir = any();

        DevoirReponseDTO devoirReponseDTO = new DevoirReponseDTO();
        devoirReponseDTO.setIdProprietaire("X");
        devoirReponseDTO.setNomFichier("Y");

        Fichier f = new Fichier();
        f.setNom(devoirReponseDTO.getNomFichier());

        Devoir devoir = new Devoir();
        devoir.setReponses(new ArrayList<>());
        given(devoirRepository.findById(idDevoir)).willReturn(Optional.of(devoir));

        DevoirReponse devoirReponse = new DevoirReponse();
        devoir.getReponses().add(devoirReponse);

        devoirReponse.setFichier(f);
        devoirReponse.setIdProprietaire(devoirReponseDTO.getIdProprietaire());
        devoirReponse.setNote(0);

        // When
        underTest.rendreDevoir(idDevoir,devoirReponseDTO);

        // Then
        verify(fichierRepository).save(f);
        verify(devoirReponseRepository).save(devoirReponse);
        verify(devoirRepository).save(devoir);
    }

    @Test
    @DisplayName("Doit noter un devoir existant")
    void doitNoterUnDevoirExistant() {
        // Given
        String idDevoir = "X";
        String idReponse = "Y";

        NoteDTO noteDTO = new NoteDTO();
        noteDTO.setNote(10);

        DevoirReponse devoirReponse = new DevoirReponse();
        devoirReponse.setId(idReponse);

        Devoir devoir = new Devoir();
        devoir.setReponses(new ArrayList<>());
        devoir.getReponses().add(devoirReponse);

        given(devoirRepository.findById(idDevoir)).willReturn(Optional.of(devoir));

        // When
        underTest.noterDevoir(idDevoir,idReponse,noteDTO);

        // Then
        verify(devoirReponseRepository).save(devoirReponse);
    }
}