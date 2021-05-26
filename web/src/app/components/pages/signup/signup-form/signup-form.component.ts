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
  async onSubmit(event: Event) {
    event.preventDefault();

    const { password, verifyPassword } = this.signupForm.value;
    if (password !== verifyPassword) {
      console.log({ error: "Passwords don't match" });
      return;
    }

    try {
      const res: any = await this.accountService.signupUser(
        this.signupForm.value
      );
      if (res.error) {
        throw res.error;
      }

      console.log(res);
      const { userToken, message } = res;

      this.router.navigate(['/login']);
      return;
    } catch (error) {
      console.log(error);
    }
  }
}
