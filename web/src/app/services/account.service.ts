import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { of } from 'rxjs';

interface User {
  id: number;
  nom: string;
  prenom: string;
  email: string;
  password: string;
  estProfesseur: boolean;
  enseigneA: string;
  etudieA: string;
  langue: string;
}

@Injectable({
  providedIn: 'root',
})
export class AccountService {
  constructor(private http: HttpClient) {}

  /**
   * Récupérer un utilisateur
   */
  getUser(userId: number) {
    return this.http.get(`/account/update/${userId}`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  /**
   * Connecter un utilisateur
   */
  loginUser({ email, password }: User) {
    return this.http
      .post('/account/auth', {
        email,
        password,
      })
      .pipe(
        catchError((err) => {
          return of(err);
        })
      );
  }

  /**
   * Enregistrer un nouvel utilisateur
   */
  signupUser({ nom, prenom, email, password }: User) {
    return this.http
      .post('/account/register', {
        nom,
        prenom,
        email,
        password,
      })
      .pipe(
        catchError((err) => {
          return of(err);
        })
      );
  }

  // TODO vérifer autorisation
  /**
   * Mise à jour d'un utilisateur, a besoin d'autorisation
   */
  updateUser(user: User) {
    return this.http.put(`/account/update/${user.id}`, { ...user }).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }

  // TODO vérifer autorisation
  /**
   * Supprime un utilisateur, a besoin d'autorisation
   */
  deleteUser(userId: number) {
    return this.http.delete(`/account/update/${userId}`).pipe(
      catchError((err) => {
        return of(err);
      })
    );
  }
}