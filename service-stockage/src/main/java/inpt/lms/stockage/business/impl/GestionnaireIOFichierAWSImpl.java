package inpt.lms.stockage.business.impl;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;

import com.amazonaws.SdkClientException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.S3Object;

import inpt.lms.stockage.business.interfaces.GestionnaireIOFichier;


public class GestionnaireIOFichierAWSImpl implements GestionnaireIOFichier {
	protected String directory;
	protected AmazonS3 s3Client;
	public GestionnaireIOFichierAWSImpl() {}

	public GestionnaireIOFichierAWSImpl(String directory,AmazonS3 s3Client) {
		this.directory = directory;
		this.s3Client = s3Client;
	}

	@Override
	public String ecrireFichier(byte[] fichier, String chemin, String nom) 
			throws IOException {

        String keyName = chemin+"/"+(nom.equals("") ? 
        		UUID.randomUUID().toString().replace("-","") : nom);
        ByteArrayInputStream inputStream = new ByteArrayInputStream(fichier);
        try {
            s3Client.putObject(directory, keyName,inputStream,new ObjectMetadata());
        } catch (SdkClientException e) { throw new IOException();} 
		return keyName;
	}

	@Override
	public byte[] lireFichier(String chemin) throws IOException {
		try (S3Object object =
				s3Client.getObject(new GetObjectRequest(directory,chemin))){
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			
			InputStream in = object.getObjectContent();
			byte[] b = new byte[2048];
			int totalRead;
			while ( (totalRead = in.read(b)) != -1)
				out.write(b, 0, totalRead);
			return out.toByteArray();
        } catch (SdkClientException e) { throw new IOException(); } 
	}

	@Override
	public void supprimerFichier(String chemin) throws IOException {
		try {
           s3Client.deleteObject(directory, chemin);
       } catch (SdkClientException e) { throw new IOException(); }
	}

	@Override
	public String getDirectory() {
		return directory;
	}

	@Override
	public void setDirectory(String directory) {
		this.directory = directory;
	}

	public AmazonS3 getS3Client() {
		return s3Client;
	}

	public void setS3Client(AmazonS3 s3Client) {
		this.s3Client = s3Client;
	}

	
}
