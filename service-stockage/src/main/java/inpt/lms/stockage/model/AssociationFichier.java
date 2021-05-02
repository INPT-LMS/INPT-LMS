package inpt.lms.stockage.model;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class AssociationFichier {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	protected Long id;
	@ManyToOne
	protected FichierInfo fichierInfo;
	@Enumerated(EnumType.STRING)
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
}
