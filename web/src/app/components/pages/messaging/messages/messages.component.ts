import { Component, OnInit } from '@angular/core';
import { AccountService } from 'src/app/services/account.service';
import { MessageboxService } from 'src/app/services/messagebox.service';
import { Conversation } from 'src/app/utils/Types';

@Component({
  selector: 'app-messages',
  templateUrl: './messages.component.html',
  styleUrls: ['./messages.component.css'],
})
export class MessagesComponent implements OnInit {
  conversations: Conversation[];

  constructor(private messageboxService: MessageboxService) {
    this.conversations = [];
  }

  ngOnInit(): void {
    this.messageboxService.getDiscussions().subscribe((res: any) => {
      this.conversations = res.content;
    });
  }
}
