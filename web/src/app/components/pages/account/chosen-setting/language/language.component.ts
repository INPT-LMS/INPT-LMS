import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { AccountService } from 'src/app/services/account.service';
import { LocalStorageService } from 'src/app/services/local-storage.service';
import { User } from 'src/app/utils/Types';

@Component({
  selector: 'app-language',
  templateUrl: './language.component.html',
  styleUrls: ['./language.component.css'],
})
export class LanguageComponent implements OnInit {
  user: User;
  languageForm = this.formBuilder.group({
    language: '',
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
      this.languageForm.get('language')?.setValue(this.user.langue);
    } catch (error) {
      console.log(error);
    }
  }

  async onSubmit(event: Event) {
    const langue = this.languageForm.value.language;
    this.user.langue = langue;
    try {
      const res = await this.accountService.updateUser(this.user);
      console.log(res);
    } catch (error) {
      console.log(error);
    }
  }
}
