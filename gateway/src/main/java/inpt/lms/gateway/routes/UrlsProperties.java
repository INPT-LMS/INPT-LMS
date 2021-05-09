package inpt.lms.gateway.routes;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties("inpt.lms.url.service")
public class UrlsProperties {
	protected String stockage;
	protected String messagerie;
	protected String gestioncompte;
	protected String devoir;
	protected String publication;
	protected String cours;
	public String getStockage() {
		return stockage;
	}
	public void setStockage(String stockage) {
		this.stockage = stockage;
	}
	public String getMessagerie() {
		return messagerie;
	}
	public void setMessagerie(String messagerie) {
		this.messagerie = messagerie;
	}
	public String getGestioncompte() {
		return gestioncompte;
	}
	public void setGestioncompte(String gestioncompte) {
		this.gestioncompte = gestioncompte;
	}
	public String getDevoir() {
		return devoir;
	}
	public void setDevoir(String devoir) {
		this.devoir = devoir;
	}
	public String getPublication() {
		return publication;
	}
	public void setPublication(String publication) {
		this.publication = publication;
	}
	public String getCours() {
		return cours;
	}
	public void setCours(String cours) {
		this.cours = cours;
	}
}
