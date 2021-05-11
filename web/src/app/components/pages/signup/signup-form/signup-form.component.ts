import { Component, ErrorHandler, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { AccountService } from 'src/app/services/account.service';
import { LocalStorageService } from 'src/app/services/local-storage.service';

@Component({
  selector: 'app-signup-form',
  templateUrl: './signup-form.component.html',
  styleUrls: ['./signup-form.component.css'],
})
export class SignupFormComponent implements OnInit {
  signupForm = this.formBuilder.group({
    nom: '',
    prenom: '',
    email: '',
    password: '',
    verifyPassword: '',
  });

  constructor(
    private accountService: AccountService,
    private localStorageService: LocalStorageService,
    private formBuilder: FormBuilder,
    private router: Router,
    private errorHandler: ErrorHandler
  ) {}

  ngOnInit(): void {}

  // Signup the user
  onSubmit(event: Event) {
    event.preventDefault();

    const { password, verifyPassword } = this.signupForm.value;
    if (password !== verifyPassword) {
      console.log({ error: "Passwords don't match" });
      return;
    }

    this.accountService
      .signupUser(this.signupForm.value)
      .subscribe((response: any) => {
        if (response.error) {
          this.errorHandler.handleError(response);
          return;
        }

        console.log(response);
        const { userToken, message } = response;

        this.router.navigate(['/login']);
        return;
      });
  }
}
