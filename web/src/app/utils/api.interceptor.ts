import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
} from '@angular/common/http';
import { Observable } from 'rxjs';
import { LocalStorageService } from '../services/local-storage.service';

const API_LINK = 'http://localhost:8080';

@Injectable()
export class ApiInterceptor implements HttpInterceptor {
  constructor(private localStorageService: LocalStorageService) {}

  intercept(
    request: HttpRequest<unknown>,
    next: HttpHandler
  ): Observable<HttpEvent<unknown>> {
    const token = this.localStorageService.get('userToken');

    const apiReq = request.clone({
      url: `${API_LINK}${request.url}`,
      headers: request.headers.append('Authorization', `Bearer ${token}`),
    });

    return next.handle(apiReq);
  }
}
