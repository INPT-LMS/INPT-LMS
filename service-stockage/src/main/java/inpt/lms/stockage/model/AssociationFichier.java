package inpt.lms.stockage.model;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonView;

@Entity
public class AssociationFichier {
	public static interface Public{}
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@JsonView(Public.class)
	protected Long id;
	@ManyToOne
	protected FichierInfo fichierInfo;
	@Enumerated(EnumType.STRING)
	@JsonView(Public.class)
	protected TypeAssociation typeAssociation;
	protected String idCorrespondantAssociation;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public FichierInfo getFichierInfo() {
		return fichierInfo;
	}
	public void setFichierInfo(FichierInfo fichierInfo) {
		this.fichierInfo = fichierInfo;
	}
	public TypeAssociation getTypeAssociation() {
		return typeAssociation;
	}
	public void setTypeAssociation(TypeAssociation typeAssociation) {
		this.typeAssociation = typeAssociation;
	}
	public String getIdCorrespondantAssociation() {
		return idCorrespondantAssociation;
	}
	public void setIdCorrespondantAssociation(String idCorrespondantAssociation) {
		this.idCorrespondantAssociation = idCorrespondantAssociation;
	}
	
	/**
	 * Fonction qui masque les proprietes non necessaires pour l'utilisateur.<br />
	 * Elle est necessaire à cause d'une incompatibilité entre l'annotation JsonView et
	 * l'interface Page
	 */
	public static AssociationFichier masquerProprietes(AssociationFichier assoc) {
		assoc.setIdCorrespondantAssociation(null);
		assoc.setFichierInfo(FichierInfo.masquerProprietes(assoc.getFichierInfo()));
		return assoc;
	}
}
