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
    this.http.get(`${PUBLICATION_BASE_URL}/files/${publicationID}/files`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Récupère un fichier dans une publication
   */
  getFichierPublication(publicationID: string, assocId: number) {
    this.http
      .get(`${PUBLICATION_BASE_URL}/files/${publicationID}/files/${assocId}`)
      .pipe(
        catchError((err) => {
          return of(err);
        })
      );
  }

  /**
   * Récupère les information d'un fichier dans une publication
   */
  getInfoFichierPublication(publicationID: string, assocId: number) {
    this.http
      .get(
        `${PUBLICATION_BASE_URL}/files/${publicationID}/files/${assocId}/info`
      )
      .pipe(
        catchError((err) => {
          return of(err);
        })
      );
  }

  /**
   * Ajoute un fichier à une publication
   */
  addFichierPublication(publicationID: string, assocId: number) {
    this.http
      .post(`${PUBLICATION_BASE_URL}/files/${publicationID}/files`, { assocId })
      .pipe(
        catchError((err) => {
          return of(err);
        })
      );
  }

  /**
   * Supprime un fichier d'une publication
   */
  deleteFichierPublication(publicationID: string, assocId: number) {
    this.http
      .delete(`${PUBLICATION_BASE_URL}/files/${publicationID}/files/${assocId}`)
      .pipe(
        catchError((err) => {
          return of(err);
        })
      );
  }

  /**
   * Récupère le contenu d'un sac
   */
  getAllFichiersSac() {
    this.http.get(`${USER_FILES_BASE_URL}/files`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Récupère un fichier du sac
   */
  getFichierSac(assocId: number) {
    this.http.get(`${USER_FILES_BASE_URL}/files/${assocId}`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Récupère les infos d'un fichier du sac
   */
  getInfoFichiersSac(assocId: number) {
    this.http.get(`${USER_FILES_BASE_URL}/files/${assocId}/info`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Ajoute un fichier dans un sac, ceci n'est qu'un copie du fichier
   */
  addFichierSac(assocId: number) {
    this.http.post(`${PUBLICATION_BASE_URL}/files`, { assocId }).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  // TODO Upload à vérifier
  /**
   * Upload un fichier dans un sac, ce fichier est ajouté automatiquement après
   */
  uploadFichierSac(file: File) {
    const data = new FormData();
    data.append('file', file);
    this.http.post(`${PUBLICATION_BASE_URL}/upload`, data).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Supprime un fichier du sac
   */
  deleteFichierSac(assocId: number) {
    this.http.delete(`${PUBLICATION_BASE_URL}/files/${assocId}`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }
}
