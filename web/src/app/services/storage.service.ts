import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { of } from 'rxjs';
import { catchError } from 'rxjs/operators';

const PUBLICATION_BASE_URL = '/storage/publication';
const USER_FILES_BASE_URL = '/storage/user';

@Injectable({
  providedIn: 'root',
})
export class StorageService {
  constructor(private http: HttpClient) {}

  /**
   * Récupère les fichiers d'une publication
   */
  getAllFichiersPublication(publicationID: string) {
    this.http
      .get(`${PUBLICATION_BASE_URL}/files/${publicationID}/files`)
      .toPromise();
  }

  /**
   * Récupère un fichier dans une publication
   */
  getFichierPublication(publicationID: string, assocId: number) {
    this.http
      .get(`${PUBLICATION_BASE_URL}/files/${publicationID}/files/${assocId}`)
      .toPromise();
  }

  /**
   * Récupère les information d'un fichier dans une publication
   */
  getInfoFichierPublication(publicationID: string, assocId: number) {
    this.http
      .get(
        `${PUBLICATION_BASE_URL}/files/${publicationID}/files/${assocId}/info`
      )
      .toPromise();
  }

  /**
   * Ajoute un fichier à une publication
   */
  addFichierPublication(publicationID: string, assocId: number) {
    this.http
      .post(`${PUBLICATION_BASE_URL}/files/${publicationID}/files`, { assocId })
      .toPromise();
  }

  /**
   * Supprime un fichier d'une publication
   */
  deleteFichierPublication(publicationID: string, assocId: number) {
    this.http
      .delete(`${PUBLICATION_BASE_URL}/files/${publicationID}/files/${assocId}`)
      .toPromise();
  }

  /**
   * Récupère le contenu d'un sac
   */
  getAllFichiersSac() {
    this.http.get(`${USER_FILES_BASE_URL}/files`).toPromise();
  }

  /**
   * Récupère un fichier du sac
   */
  getFichierSac(assocId: number) {
    this.http.get(`${USER_FILES_BASE_URL}/files/${assocId}`).toPromise();
  }

  /**
   * Récupère les infos d'un fichier du sac
   */
  getInfoFichiersSac(assocId: number) {
    this.http.get(`${USER_FILES_BASE_URL}/files/${assocId}/info`).toPromise();
  }

  /**
   * Ajoute un fichier dans un sac, ceci n'est qu'un copie du fichier
   */
  addFichierSac(assocId: number) {
    this.http.post(`${PUBLICATION_BASE_URL}/files`, { assocId }).toPromise();
  }

  // TODO Upload à vérifier
  /**
   * Upload un fichier dans un sac, ce fichier est ajouté automatiquement après
   */
  uploadFichierSac(file: File) {
    const data = new FormData();
    data.append('fichier', file);
    this.http.post(`${PUBLICATION_BASE_URL}/upload`, data).toPromise();
  }

  /**
   * Supprime un fichier du sac
   */
  deleteFichierSac(assocId: number) {
    this.http.delete(`${PUBLICATION_BASE_URL}/files/${assocId}`).toPromise();
  }
}
