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
  otherUser: string;
  otherUserId: number;

  constructor(private localStorageService: LocalStorageService) {
    this.messageItem = {
      id: '',
      nomParticipant1: '',
      nomParticipant2: '',
      idParticipant1: -1,
      idParticipant2: -1,
      lastMessage: {
        contenu: '',
      },
    };
    this.otherUser = '';
    this.otherUserId = -1;
  }

  ngOnInit(): void {
    this.otherUserId =
      this.messageItem.idParticipant1 !==
      parseInt(this.localStorageService.get('userId')!)
        ? this.messageItem.idParticipant1
        : this.messageItem.idParticipant2;

    this.otherUser =
      this.otherUserId === this.messageItem.idParticipant1
        ? this.messageItem.nomParticipant1
        : this.messageItem.nomParticipant2;
  }
}
