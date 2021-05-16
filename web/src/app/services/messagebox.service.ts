import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { Message } from '../utils/Types';

const DISCUSSION_BASE_URL = '/messagebox/discussion';
const INFOS_BASE_URL = '/messagebox/infos';

@Injectable({
  providedIn: 'root',
})
export class MessageboxService {
  constructor(private http: HttpClient) {}

  /**
   * Envoyer un message à un destinataire
   */
  sendMessage({ idDestinataire, contenu }: Message) {
    return this.http
      .post(`${DISCUSSION_BASE_URL}`, { idDestinataire, contenu })
      .pipe(
        catchError((err) => {
          return of(err);
        })
      );
  }

  /**
   * Récupérer les messages d'une discussion
   */
  getMessages(discId: string, page: number = 0) {
    return this.http.get(`${DISCUSSION_BASE_URL}/${discId}?page=${page}`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Récupérer les nouveaux messages d'une discussion
   */
  getNewMessages(discId: string) {
    return this.http.get(`${DISCUSSION_BASE_URL}/${discId}/new`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Récupère toutes les discussions
   */
  getDiscussions(page: number = 0) {
    return this.http.get(`${INFOS_BASE_URL}?page=${page}`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Récupère toutes les discussions
   */
  getNewDiscussions() {
    return this.http.get(`${INFOS_BASE_URL}/new`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }
}
