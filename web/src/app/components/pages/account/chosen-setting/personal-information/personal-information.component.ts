import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { AccountService } from 'src/app/services/account.service';
import { LocalStorageService } from 'src/app/services/local-storage.service';
import { User } from 'src/app/utils/Types';

@Component({
  selector: 'app-personal-information',
  templateUrl: './personal-information.component.html',
  styleUrls: ['./personal-information.component.css'],
})
export class PersonalInformationComponent implements OnInit {
  user: User;
  informationsForm = this.formBuilder.group({
    nom: '',
    prenom: '',
    email: '',
    etudieA: '',
  });

  constructor(
    private accountService: AccountService,
    private localStorageService: LocalStorageService,
    private formBuilder: FormBuilder
  ) {
    this.user = {};
  }

  async ngOnInit(): Promise<void> {
    const userId = parseInt(this.localStorageService.get('userId')!);

    try {
      const res: any = await this.accountService.getUser(userId);
      this.user = res.user;
      this.user.id = userId;
      this.informationsForm.get('nom')?.setValue(this.user.nom);
      this.informationsForm.get('prenom')?.setValue(this.user.prenom);
      this.informationsForm.get('email')?.setValue(this.user.email);
      this.informationsForm.get('etudieA')?.setValue(this.user.etudieA);
    } catch (error) {
      console.log(error);
    }
  }

  async onSubmit(event: Event) {
    const updatedUser = {
      ...this.user,
      ...this.informationsForm.value,
    };

    console.log(updatedUser);

    try {
      const res = await this.accountService.updateUser(updatedUser);
      console.log(res);
    } catch (error) {
      console.log(error);
    }
  }
}
