import { HttpClient, HttpHeaders } from '@angular/common/http';
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
  private httpOptions: any;
  constructor(private http: HttpClient) {}

  /**
   * Récupère tous les devoirs d'un cours
   */
  getDevoirsForClass(classId: string) {
    let headers = new HttpHeaders();
    headers.append('Authorization', 'Bearer ' + 'tst');
    this.httpOptions = {
      headers: headers,
    };
    return this.http
      .get(`/assignment/devoirs/${classId}`, this.httpOptions)
      .pipe(
        catchError((err) => {
          return of(err);
        })
      );
  }

  /**
   * Récupère un seul devoir dans un cours
   */
  getDevoir(classId: string, devoirId: number) {
    return this.http
      .get(`/assignment/devoirs/${classId}/${devoirId}`, this.httpOptions)
      .pipe(
        catchError((err) => {
          return of(err);
        })
      );
  }

  /**
   * Ajoute un devoir dans un cours
   */
  addDevoir(classId: string, devoir: Devoir) {
    return this.http
      .post(`/assignment/devoirs/${classId}`, devoir, this.httpOptions)
      .pipe(
        catchError((err) => {
          return of(err);
        })
      );
  }

  /**
   * Ajoute un rendu pour un devoir
   */
  addRenduDevoir(classId: string, devoirId: string, renduDevoir: RenduDevoir) {
    return this.http
      .put(
        `/assignment/devoirs/${classId}/${devoirId}/rendu`,
        renduDevoir,
        this.httpOptions
      )
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
    classId: string,
    devoirId: string,
    renduId: string,
    note: number
  ) {
    return this.http
      .put(
        `/assignment/devoirs/${classId}/${devoirId}/rendu/${renduId}`,
        note,
        this.httpOptions
      )
      .pipe(
        catchError((err) => {
          return of(err);
        })
      );
  }
}
