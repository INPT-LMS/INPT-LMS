import { Component, ErrorHandler, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { AccountService } from 'src/app/services/account.service';
import { LocalStorageService } from 'src/app/services/local-storage.service';

@Component({
  selector: 'app-login-form',
  templateUrl: './login-form.component.html',
  styleUrls: ['./login-form.component.css'],
})
export class LoginFormComponent implements OnInit {
  loginForm = this.formBuilder.group({
    email: '',
    password: '',
  });

  constructor(
    private accountService: AccountService,
    private localStorageService: LocalStorageService,
    private formBuilder: FormBuilder,
    private router: Router,
    private errorHandler: ErrorHandler
  ) {}

  ngOnInit(): void {}

  // Login the user
  onSubmit(event: Event) {
    event.preventDefault();

    this.accountService
      .loginUser(this.loginForm.value)
      .subscribe((response: any) => {
        if (response.error) {
          this.errorHandler.handleError(response);
          return;
        }

        const { userToken, message } = response;
        this.localStorageService.set('userToken', userToken);

        this.router.navigate(['/feed']);
        return;
      });
  }
}
