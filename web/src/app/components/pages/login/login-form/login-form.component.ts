import { Component, ErrorHandler, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { Store } from '@ngrx/store';
import { Observable } from 'rxjs';
import { LOGIN_USER, USER_ERROR } from 'src/app/actiontypes/types';
import { AccountService } from 'src/app/services/account.service';
import { LocalStorageService } from 'src/app/services/local-storage.service';
import { User } from 'src/app/utils/Types';

interface AppState {
  user: User;
  error: string;
}

@Component({
  selector: 'app-login-form',
  templateUrl: './login-form.component.html',
  styleUrls: ['./login-form.component.css'],
})
export class LoginFormComponent implements OnInit {
  user: Observable<User>;
  loginForm = this.formBuilder.group({
    email: '',
    password: '',
  });

  constructor(
    private accountService: AccountService,
    private localStorageService: LocalStorageService,
    private formBuilder: FormBuilder,
    private router: Router,
    private errorHandler: ErrorHandler,
    private store: Store<AppState>
  ) {
    this.user = this.store.select('user');
  }

  ngOnInit(): void {}

  // Login the user
  onSubmit(event: Event) {
    event.preventDefault();

    this.accountService
      .loginUser(this.loginForm.value)
      .subscribe((response: any) => {
        if (response.error || !response.user) {
          this.errorHandler.handleError(response);
          this.store.dispatch({ type: USER_ERROR, payload: response.error });
          return;
        }

        const {
          user: { id, email, token },
          message,
        } = response;
        this.localStorageService.set('userToken', token);
        this.localStorageService.set('userId', id);

        // TODO dispatch user infos
        const payload = {
          id,
          email,
        };

        this.store.dispatch({ type: LOGIN_USER, payload: payload });
        this.router.navigate(['/feed']);
        return;
      });
  }
}
