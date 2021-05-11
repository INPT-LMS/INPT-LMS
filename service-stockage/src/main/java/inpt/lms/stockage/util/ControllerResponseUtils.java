package inpt.lms.stockage.util;

import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;

import inpt.lms.stockage.business.interfaces.FichierEtInfo;
import inpt.lms.stockage.model.FichierInfo;

public class ControllerResponseUtils {
	private ControllerResponseUtils() {
		throw new IllegalStateException("Utility class");
	}
	
	public static ResponseEntity<byte[]> lireFichier(FichierEtInfo fichier){
		FichierInfo info = fichier.getFichierInfo();
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION,
				"attachment; filename=\"" + info.getNom() + "\"")
				.header(HttpHeaders.CONTENT_TYPE, info.getContentType())
				.body(fichier.getFichierContenu());
	}
}
