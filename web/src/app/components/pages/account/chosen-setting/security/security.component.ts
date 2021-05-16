import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { AccountService } from 'src/app/services/account.service';
import { LocalStorageService } from 'src/app/services/local-storage.service';

@Component({
  selector: 'app-security',
  templateUrl: './security.component.html',
  styleUrls: ['./security.component.css'],
})
export class SecurityComponent implements OnInit {
  passwordForm = this.formBuilder.group({
    oldPassword: '',
    newPassword: '',
    confirmedPassword: '',
  });

  constructor(
    private accountService: AccountService,
    private localStorageService: LocalStorageService,
    private formBuilder: FormBuilder
  ) {}

  ngOnInit(): void {}

  onSubmit(event: Event) {
    event.preventDefault();

    const oldPassword = this.passwordForm.value.oldPassword;
    const newPassword = this.passwordForm.value.newPassword;
    const confirmedPassword = this.passwordForm.value.confirmedPassword;

    if (newPassword !== confirmedPassword) {
      console.log({ error: "Passwords don't match" });
    } else {
      const userId = parseInt(this.localStorageService.get('userId')!);
      const payload = {
        userId,
        oldPassword,
        newPassword,
      };

      this.accountService.updateUserPassword(payload).subscribe((res: any) => {
        console.log(res);
      });
    }
  }
}
