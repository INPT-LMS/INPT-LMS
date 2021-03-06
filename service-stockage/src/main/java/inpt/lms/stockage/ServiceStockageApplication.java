package inpt.lms.stockage;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.context.annotation.Bean;
import org.springframework.web.filter.ShallowEtagHeaderFilter;

import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

import inpt.lms.stockage.business.impl.GestionnaireIOFichierAWSImpl;
import inpt.lms.stockage.business.impl.GestionnaireIOFichierLocalImpl;
import inpt.lms.stockage.business.interfaces.GestionnaireIOFichier;
import inpt.lms.stockage.proxies.CustomErrorDecoder;

@EnableFeignClients
@SpringBootApplication
public class ServiceStockageApplication{

	public static void main(String[] args) {
		SpringApplication.run(ServiceStockageApplication.class, args);
	}
	
	@Bean
	@ConditionalOnProperty(prefix = "inpt.lms.stockage", name = "local",
		havingValue = "false",matchIfMissing = true)
	public AmazonS3 getS3Client() {
		return AmazonS3ClientBuilder.standard()
        .withRegion(Regions.US_EAST_2)
        .build();
	}
	
	@Bean
	@ConditionalOnProperty(prefix = "inpt.lms.stockage", name = "local",
	havingValue = "false",matchIfMissing = true)
	public GestionnaireIOFichier getIOFichierAWS(
			@Value("${inpt.lms.stockage.directory}") String directory,
			AmazonS3 s3Client) {
		
		return new GestionnaireIOFichierAWSImpl(directory,s3Client);
	}
	
	@Bean
	@ConditionalOnProperty(prefix = "inpt.lms.stockage", name = "local",
	havingValue = "true")
	public GestionnaireIOFichier getIOFichierLocal(
			@Value("${inpt.lms.stockage.directory}") String directory) {
		
		return new GestionnaireIOFichierLocalImpl(directory);
	}
	
	@Bean
	public CustomErrorDecoder getErrorDecoder() {
		return new CustomErrorDecoder();
	}

	@Bean
	public ShallowEtagHeaderFilter shallowEtagHeaderFilter() {
	    return new ShallowEtagHeaderFilter();
	}
}