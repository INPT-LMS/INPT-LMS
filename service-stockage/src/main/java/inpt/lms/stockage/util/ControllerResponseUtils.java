package inpt.lms.stockage.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.apache.tika.config.TikaConfig;
import org.apache.tika.exception.TikaException;
import org.apache.tika.io.TikaInputStream;
import org.apache.tika.metadata.Metadata;
import org.apache.tika.metadata.TikaMetadataKeys;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.http.ResponseEntity.BodyBuilder;
import org.springframework.web.multipart.MultipartFile;

import inpt.lms.stockage.business.interfaces.FichierEtInfo;
import inpt.lms.stockage.controller.exceptions.InvalidFileTypeException;
import inpt.lms.stockage.model.FichierInfo;

public class ControllerResponseUtils {
	private ControllerResponseUtils() {
		throw new IllegalStateException("Utility class");
	}
	
	private static ResponseEntity<byte[]> finirReponse(BodyBuilder response,
			FichierEtInfo fichier){
		FichierInfo info = fichier.getFichierInfo();
		return response.header(HttpHeaders.CONTENT_DISPOSITION,
				"attachment; filename=\"" + info.getNom() + "\"")
				.header(HttpHeaders.CONTENT_TYPE, info.getContentType())
				.body(fichier.getFichierContenu());
	}
	
	public static ResponseEntity<byte[]> lireFichier(FichierEtInfo fichier){
		return finirReponse(ResponseEntity.ok(), fichier);
	}
	
	public static ResponseEntity<byte[]> lireFichierAvecCache(FichierEtInfo fichier){
		BodyBuilder response = ResponseEntity.ok().cacheControl(
				CacheControl.maxAge(180, TimeUnit.SECONDS)
			      .noTransform()
			      .mustRevalidate());
		return finirReponse(response, fichier);
	}
	
	public static String getMimeType(InputStream stream,String filename) throws IOException{
		TikaConfig tika;
		try {
			tika = new TikaConfig();
		} catch (TikaException e) {
			throw new IOException();
		}
		
		Metadata metadata = new Metadata();
		metadata.set(TikaMetadataKeys.RESOURCE_NAME_KEY, filename);
		return tika.getDetector().detect(
		        TikaInputStream.get(stream), metadata).toString();
	}
	
	public static void checkContentType( MultipartFile fichier, List<String> supportedTypes) 
			throws InvalidFileTypeException, IOException {
		String contentType = fichier.getContentType();
		if (contentType == null || !(supportedTypes.contains(contentType)))
			throw new InvalidFileTypeException(supportedTypes);
		
		String mimeType = getMimeType(fichier.getInputStream(), 
				fichier.getOriginalFilename());
		
		if (!supportedTypes.contains(mimeType))
			throw new InvalidFileTypeException(supportedTypes);
	}
	
	public static void checkContentType(MultipartFile fichier) 
			throws InvalidFileTypeException, IOException {
		String contentType = fichier.getContentType();
	
		String mimeType = getMimeType(fichier.getInputStream(), 
				fichier.getOriginalFilename());
		
		if (!mimeType.equals("application/octet-stream ") && !mimeType.equals(contentType))
			throw new InvalidFileTypeException(mimeType,contentType);
	}
}
