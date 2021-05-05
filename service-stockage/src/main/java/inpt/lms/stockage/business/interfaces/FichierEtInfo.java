package inpt.lms.stockage.business.interfaces;

import inpt.lms.stockage.model.FichierInfo;

public class FichierEtInfo {
	protected FichierInfo fichierInfo;
	protected byte[] fichierContenu;
	
	public FichierInfo getFichierInfo() {
		return fichierInfo;
	}
	public void setFichierInfo(FichierInfo fichierInfo) {
		this.fichierInfo = fichierInfo;
	}
	public byte[] getFichierContenu() {
		return fichierContenu;
	}
	public void setFichierContenu(byte[] fichierContenu) {
		this.fichierContenu = fichierContenu;
	}
	
}
