import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { of } from 'rxjs';
import { catchError } from 'rxjs/operators';

interface Devoir {
  idProprietiare: number;
  type: string;
  contenu: string;
}

interface RenduDevoir {
  idProprietiare: number;
  nomFichier: string;
}

@Injectable({
  providedIn: 'root',
})
export class AssignmentService {
  constructor(private http: HttpClient) {}

  /**
   * Récupère tous les devoirs d'un cours
   */
  getDevoirsForClass(classId: number) {
    return this.http.get(`/assignment/devoirs/${classId}`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Récupère un seul devoir dans un cours
   */
  getDevoir(classId: number, devoirId: number) {
    return this.http.get(`/assignment/devoirs/${classId}/${devoirId}`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Ajoute un devoir dans un cours
   */
  addDevoir(classId: number, devoir: Devoir) {
    return this.http.post(`/assignment/devoirs/${classId}`, devoir).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Ajoute un rendu pour un devoir
   */
  addRenduDevoir(classId: number, devoirId: number, renduDevoir: RenduDevoir) {
    return this.http
      .put(`/assignment/devoirs/${classId}/${devoirId}/rendu`, renduDevoir)
      .pipe(
        catchError((err) => {
          return of(err);
        })
      );
  }

  /**
   * Note un rendu d'un devoir
   */
  noteRenduDevoir(
    classId: number,
    devoirId: number,
    renduId: number,
    note: number
  ) {
    return this.http
      .put(`/assignment/devoirs/${classId}/${devoirId}/rendu/${renduId}`, note)
      .pipe(
        catchError((err) => {
          return of(err);
        })
      );
  }
}
