import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { AccountService } from 'src/app/services/account.service';

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
    private formBuilder: FormBuilder,
    private router: Router
  ) {}

  ngOnInit(): void {}

  // TODO Enregistrer le token
  // TODO Vérifier le cas d'erreur
  // Signup the user
  onSubmit(event: Event) {
    event.preventDefault();

    this.accountService.signupUser(this.signupForm.value).subscribe();

    this.router.navigate(['/feed']);
  }
}
