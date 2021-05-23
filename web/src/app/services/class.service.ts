import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { of } from 'rxjs';
import { catchError } from 'rxjs/operators';

const BASE_URL = '/class';

interface Course {
  courseID: string;
  courseName: string;
  courseDescription: string;
  imageURL: string;
}

@Injectable({
  providedIn: 'root',
})
export class ClassService {
  constructor(private http: HttpClient) {}

  /**
   * Récupère tous les cours d'un prof
   */
  getAllStudentCourses() {
    return this.http.get(`${BASE_URL}/student/courses`).toPromise();
  }

  /**
   * Récupère tous les cours d'un prof
   */
  getAllProfessorCourses() {
    return this.http.get(`${BASE_URL}/courses/owner`).toPromise();
  }

  /**
   * Ajoute un cours
   */
  addCourseForAdmin(course: Course) {
    return this.http.post(`${BASE_URL}/course/owner`, course).toPromise();
  }

  /**
   * Récupère un seul cours
   */
  getCourseForAdmin(courseID: string) {
    return this.http.get(`${BASE_URL}/course/${courseID}/owner`).toPromise();
  }

  /**
   * Supprime un cours
   */
  deleteCourse(courseID: string) {
    return this.http.delete(`${BASE_URL}/course/${courseID}`).toPromise();
  }

  /**
   * Récupère les membres d'un cours
   */
  getCourseMembers(courseID: string) {
    return this.http.get(`${BASE_URL}/course/${courseID}/members`).toPromise();
  }

  /**
   * Ajoute un membre à un cours
   */
  addMemberInCourse(courseID: string, memberID: number) {
    return this.http
      .post(`${BASE_URL}/course/${courseID}/members/${memberID}`, {})
      .toPromise();
  }

  /**
   * Supprime un membre d'un cours
   */
  removeMemberFromCourse(courseID: string, memberID: number) {
    return this.http
      .delete(`${BASE_URL}/course/${courseID}/members/${memberID}`)
      .toPromise();
  }

  /**
   * Récupère la visibilité d'un cours
   */
  getCourseVisibility(courseID: string) {
    return this.http
      .get(`${BASE_URL}/course/${courseID}/visibility`)
      .toPromise();
  }

  /**
   * Change la visilibté d'un cours
   */
  setCourseVisiblity(courseID: string, visibilityID: number) {
    return this.http
      .put(`${BASE_URL}/course/${courseID}/visibility/${visibilityID}`, {})
      .toPromise();
  }
}
