import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Like, Publication, Commentaire } from '../utils/Types';

const PUBLICATION_BASE_URL = '/post/publication';
const LIKE_BASE_URL = '/post/like';
const COMMENT_BASE_URL = '/post/commentaire';

@Injectable({
  providedIn: 'root',
})
export class PostService {
  constructor(private http: HttpClient) {}

  /**
   * Récupère toutes les publications
   */
  getAllPublications() {
    return this.http.get(`${PUBLICATION_BASE_URL}`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Récupère une publication avec l'id de son cours
   */
  getPublication(classId: string) {
    return this.http.get(`${PUBLICATION_BASE_URL}/${classId}`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Ajoute une publication dans un cours
   */
  addPublication(publication: Publication) {
    return this.http.post(`${PUBLICATION_BASE_URL}/`, publication).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Modifie une publication
   */
  updatePublication(publication: Publication) {
    return this.http
      .put(`${PUBLICATION_BASE_URL}/${publication.idPublication}`, publication)
      .pipe(
        catchError((err) => {
          return of(err);
        })
      );
  }

  /**
   * Supprime une publication
   */
  deletePublication(publicationId: string) {
    return this.http.delete(`${PUBLICATION_BASE_URL}/${publicationId}`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Ajoute un commentaire dans une publication
   */
  addCommentaire(commentaire: Commentaire) {
    return this.http.post(`${COMMENT_BASE_URL}`, commentaire).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Modifie un commentaire dans une publication
   */
  updateCommentaire(commentaire: Commentaire) {
    return this.http
      .put(`${COMMENT_BASE_URL}/${commentaire.idCommentaire}`, commentaire)
      .pipe(
        catchError((err) => {
          return of(err);
        })
      );
  }

  /**
   * Supprime un commentaire dans une publication
   */
  deleteCommentaire(commentaireId: string) {
    return this.http.delete(`${COMMENT_BASE_URL}/${commentaireId}`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Ajoute un like dans une publication
   */
  addLike(like: Like) {
    return this.http.post(`${LIKE_BASE_URL}`, like).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Supprime un like dans une publication
   */
  deleteLike(likeId: string) {
    return this.http.delete(`${LIKE_BASE_URL}/${likeId}`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }
}
