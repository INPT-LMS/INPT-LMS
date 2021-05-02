package inpt.lms.stockage.model;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class FichierInfo {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	protected Long id;
	protected Long idProprietaire;
	protected LocalDateTime dateCreation;
	protected String nom;
	protected String chemin;
	@OneToMany(mappedBy = "fichierInfo")
	protected List<AssociationFichier> associations;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getIdProprietaire() {
		return idProprietaire;
	}
	public void setIdProprietaire(Long idProprietaire) {
		this.idProprietaire = idProprietaire;
	}
	public LocalDateTime getDateCreation() {
		return dateCreation;
	}
	public void setDateCreation(LocalDateTime dateCreation) {
		this.dateCreation = dateCreation;
	}
	public String getNom() {
		return nom;
	}
	public void setNom(String nom) {
		this.nom = nom;
	}
	public String getChemin() {
		return chemin;
	}
	public void setChemin(String chemin) {
		this.chemin = chemin;
	}
	public List<AssociationFichier> getAssociations() {
		return associations;
	}
	public void setAssociations(List<AssociationFichier> associations) {
		this.associations = associations;
	}
}
