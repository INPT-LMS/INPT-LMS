import { Component, Input, OnInit } from '@angular/core';
import { AccountService } from 'src/app/services/account.service';
import { LocalStorageService } from 'src/app/services/local-storage.service';
import { Conversation, User } from 'src/app/utils/Types';

@Component({
  selector: 'app-message-item',
  templateUrl: './message-item.component.html',
  styleUrls: ['./message-item.component.css'],
})
export class MessageItemComponent implements OnInit {
  @Input()
  messageItem: Conversation;
  otherUser: User;

  constructor(
    private accountService: AccountService,
    private localStorageService: LocalStorageService
  ) {
    this.messageItem = {
      id: '',
      idParticipant1: -1,
      idParticipant2: -1,
    };
    this.otherUser = {};
  }

  ngOnInit(): void {
    const otherUserId =
      this.messageItem.idParticipant1 !==
      parseInt(this.localStorageService.get('userId')!)
        ? this.messageItem.idParticipant1
        : this.messageItem.idParticipant2;

    this.accountService.getUser(otherUserId).subscribe((res: any) => {
      this.otherUser = res.user;
      this.otherUser.id = otherUserId;
    });
  }
}
