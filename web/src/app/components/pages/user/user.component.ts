import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { AccountService } from 'src/app/services/account.service';
import { LocalStorageService } from 'src/app/services/local-storage.service';
import { MessageboxService } from 'src/app/services/messagebox.service';
import { Message, User } from 'src/app/utils/Types';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css'],
})
export class UserComponent implements OnInit {
  @Input()
  user: User = {};
  isMe: boolean = true;
  messageForm = this.formBuilder.group({
    message: '',
  });

  constructor(
    private accountService: AccountService,
    private localStorageService: LocalStorageService,
    private messageboxService: MessageboxService,
    private formBuilder: FormBuilder,
    private router: Router
  ) {}

  async ngOnInit(): Promise<void> {
    const userId = parseInt(this.router.url.split('/').slice(-1)[0]);

    // Pas d'utilisateur dans le link, on retourne au feed
    if (isNaN(userId)) {
      this.router.navigate(['/']);
    }

    try {
      const res: any = await this.accountService.getUser(userId);
      this.user = res.user;
      this.user.id = userId;
    } catch (error) {
      if (error.status === 404) {
        // Utilisateur introuvable
        console.log('Error: ' + error.statusText);
        this.router.navigate(['/']);
      } else {
        console.log(error);
      }
    }

    const myId = parseInt(this.localStorageService.get('userId')!);
    this.isMe = userId === myId;

    console.log(this.isMe);
  }

  async onSubmit(event: Event) {
    event.preventDefault();

    const date = new Date();

    const newMessage: Message = {
      contenu: this.messageForm.value.message,
      idDestinataire: this.user.id,
      date: date.toString(),
    };

    try {
      this.messageboxService.sendMessage(newMessage);
      this.messageForm.reset();
    } catch (error) {
      console.log(error);
    }
  }
}
