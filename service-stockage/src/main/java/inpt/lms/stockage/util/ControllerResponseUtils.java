package inpt.lms.stockage.util;

import java.io.IOException;
import java.util.List;

import org.apache.tika.config.TikaConfig;
import org.apache.tika.exception.TikaException;
import org.apache.tika.io.TikaInputStream;
import org.apache.tika.metadata.Metadata;
import org.apache.tika.metadata.TikaMetadataKeys;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import inpt.lms.stockage.business.interfaces.FichierEtInfo;
import inpt.lms.stockage.controller.exceptions.InvalidFileTypeException;
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
	
	public static void checkContentType( MultipartFile fichier, List<String> supportedTypes) 
			throws InvalidFileTypeException, IOException {
		String contentType = fichier.getContentType();
		if (contentType == null || !(supportedTypes.contains(contentType)))
			throw new InvalidFileTypeException(supportedTypes);
		
		TikaConfig tika;
		try {
			tika = new TikaConfig();
		} catch (TikaException e) {
			throw new IOException();
		}
		
		Metadata metadata = new Metadata();
		metadata.set(TikaMetadataKeys.RESOURCE_NAME_KEY, fichier.getOriginalFilename());
		String mimeType = tika.getDetector().detect(
		        TikaInputStream.get(fichier.getInputStream()), metadata).toString();
		
		if (!supportedTypes.contains(mimeType))
			throw new InvalidFileTypeException(supportedTypes);
	}
}
