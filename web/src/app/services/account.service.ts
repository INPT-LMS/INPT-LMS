import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { catchError } from 'rxjs/operators';
import { of } from 'rxjs';
import { User } from '../utils/Types';

@Injectable({
  providedIn: 'root',
})
export class AccountService {
  constructor(private http: HttpClient) {}

  /**
   * Récupérer un utilisateur
   */
  getUser(userId: number) {
    return this.http.get(`/account/user/${userId}`).toPromise();
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
      .toPromise();
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
      .toPromise();
  }

  /**
   * Mise à jour d'un utilisateur, a besoin d'autorisation
   */
  updateUser(user: User) {
    return this.http.put(`/account/update/${user.id}`, { ...user }).toPromise();
  }

  /**
   * Mise à jour d'un utilisateur, a besoin d'autorisation
   */
  updateUserPassword({
    userId,
    oldPassword,
    newPassword,
  }: {
    userId: number;
    oldPassword: string;
    newPassword: string;
  }) {
    return this.http
      .put(`/account/update/password/${userId}`, { oldPassword, newPassword })
      .toPromise();
  }

  /**
   * Supprime un utilisateur, a besoin d'autorisation
   */
  deleteUser(userId: number) {
    return this.http.delete(`/account/update/${userId}`).toPromise();
  }

  /**
   * Chercher un utilisateur par son nom
   */
  searchUserByName(userName: string) {
    return this.http.get(`/account/search?name=${userName}`).toPromise();
  }
}
