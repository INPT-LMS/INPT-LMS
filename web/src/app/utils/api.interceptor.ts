import { Injectable } from '@angular/core';
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor,
} from '@angular/common/http';
import { Observable } from 'rxjs';
import { LocalStorageService } from '../services/local-storage.service';
import { environment } from 'src/environments/environment';

const API_LINK = environment.gatewayURL;

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
