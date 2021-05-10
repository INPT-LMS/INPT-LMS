import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Router } from '@angular/router';
import { AccountService } from 'src/app/services/account.service';

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
    private formBuilder: FormBuilder,
    private router: Router
  ) {}

  ngOnInit(): void {}

  // TODO Enregistrer le token
  // TODO Vérifier le cas d'erreur
  // Login the user
  onSubmit(event: Event) {
    event.preventDefault();

    this.accountService.loginUser(this.loginForm.value).subscribe();

    this.router.navigate(['/feed']);
  }
}
