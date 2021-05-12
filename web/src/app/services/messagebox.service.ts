import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { of } from 'rxjs';
import { catchError } from 'rxjs/operators';

interface MessageForm {
  idDestinataire: number;
  contenu: string;
}

const DISCUSSION_BASE_URL = '/messagebox/discussion';
const INFOS_BASE_URL = '/messagebox/discussion';

@Injectable({
  providedIn: 'root',
})
export class MessageboxService {
  constructor(private http: HttpClient) {}

  /**
   * Envoyer un message à un destinataire
   */
  sendMessage(message: MessageForm) {
    this.http.post(`${DISCUSSION_BASE_URL}`, message).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Récupérer les messages d'une discussion
   */
  getMessages(discId: string) {
    this.http.get(`${DISCUSSION_BASE_URL}/${discId}`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Récupérer les nouveaux messages d'une discussion
   */
  getNewMessages(discId: string) {
    this.http.get(`${DISCUSSION_BASE_URL}/${discId}/new`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Récupère toutes les discussions
   */
  getDiscussions() {
    this.http.get(`${INFOS_BASE_URL}`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Récupère toutes les discussions
   */
  getNewDiscussions() {
    this.http.get(`${INFOS_BASE_URL}/new`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }
}
