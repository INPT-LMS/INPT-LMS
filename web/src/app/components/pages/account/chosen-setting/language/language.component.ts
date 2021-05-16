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

  ngOnInit(): void {
    const userId = parseInt(this.localStorageService.get('userId')!);
    this.accountService.getUser(userId).subscribe((res: any) => {
      this.user = res.user;
      this.user.id = userId;
      this.languageForm.get('language')?.setValue(this.user.langue);
    });
  }

  onSubmit(event: Event) {
    const langue = this.languageForm.value.language;
    this.user.langue = langue;
    this.accountService.updateUser(this.user).subscribe((res: any) => {
      console.log(res);
    });
  }
}
