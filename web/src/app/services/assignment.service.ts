import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { DevoirInfos } from '../utils/Types';

interface RenduDevoir {
  idProprietiare: number;
  nomFichier: string;
}

@Injectable({
  providedIn: 'root',
})
export class AssignmentService {
  private httpOptions: any;
  constructor(private http: HttpClient) {}

  /**
   * Récupère tous les devoirs d'un cours
   */
  getDevoirsForClass(classId: string) {
    return this.http
      .get(`/assignment/devoirs/${classId}`, this.httpOptions)
      .toPromise();
  }

  /**
   * Récupère un seul devoir dans un cours
   */
  getDevoir(classId: string, devoirId: string) {
    return this.http
      .get(`/assignment/devoirs/${classId}/${devoirId}`, this.httpOptions)
      .toPromise();
  }

  /**
   * Récupère ma propre réponse d'un devoir
   */
  getOwnReponseDevoir(classId: string, devoirId: string) {
    return this.http
      .get(`/storage/assignment/${classId}/${devoirId}/response`, {
        responseType: 'blob',
      })
      .toPromise();
  }

  getUserReponseDevoir(
    idProprietaire: number,
    classId: string,
    devoirId: string
  ) {
    return this.http
      .get(
        `/storage/assignment/${classId}/${devoirId}/response/${idProprietaire}`,
        {
          responseType: 'blob',
        }
      )
      .toPromise();
  }

  /**
   * Ajoute un devoir dans un cours
   */
  addDevoir(
    classId: string,
    devoir: { contenu: string; type: 'DEVOIR' | 'QUIZZ'; dateLimite: Date }
  ) {
    return this.http
      .post(`/assignment/devoirs/${classId}`, devoir, this.httpOptions)
      .toPromise();
  }

  /**
   * Ajoute un rendu pour un devoir
   */
  addRenduDevoir(classId: string, devoirId: string, file: File) {
    let formData = new FormData();
    formData.append('fichier', file);
    return this.http
      .put(
        `/assignment/devoirs/${classId}/${devoirId}/rendu`,
        formData,
        this.httpOptions
      )
      .toPromise();
  }

  /**
   * Note un rendu d'un devoir
   */
  noteRenduDevoir(
    classId: string,
    devoirId: string,
    renduId: string,
    note: number
  ) {
    return this.http
      .put(
        `/assignment/devoirs/${classId}/${devoirId}/rendu/${renduId}`,
        { note: note },
        this.httpOptions
      )
      .toPromise();
  }
}
