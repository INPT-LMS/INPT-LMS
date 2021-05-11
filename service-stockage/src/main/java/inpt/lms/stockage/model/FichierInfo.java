package inpt.lms.stockage.model;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonView;

@Entity
public class FichierInfo {
	public static interface Public{}
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	protected Long id;
	protected Long idProprietaire;
	@JsonView(Public.class)
	protected LocalDateTime dateCreation;
	@JsonView(Public.class)
	protected String nom;
	protected String chemin;
	@JsonView(Public.class)
	protected long size;
	@JsonView(Public.class)
	protected String contentType;
	@OneToMany(mappedBy = "fichierInfo", cascade = CascadeType.REMOVE)
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
	/**
	 * Retourne la taille du fichier en octets
	 * @return Taille du fichier en octets
	 */
	public long getSize() {
		return size;
	}
	/**
	 * Change la taille du fichier
	 * @param size Taille en octet
	 */
	public void setSize(long size) {
		this.size = size;
	}
	public String getContentType() {
		return contentType;
	}
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	
	/**
	 * Fonction qui masque les proprietes non necessaires pour l'utilisateur.\n
	 * Elle est necessaire à cause d'une incompatibilité entre l'annotation JsonView et
	 * l'interface Page
	 */
	public static FichierInfo masquerProprietes(FichierInfo fInfo) {
		fInfo.setAssociations(null);
		fInfo.setChemin(null);
		fInfo.setId(null);
		fInfo.setIdProprietaire(null);
		return fInfo;
	}
	
}
