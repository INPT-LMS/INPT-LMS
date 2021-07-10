import { Component, OnInit } from '@angular/core';
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

  async ngOnInit(): Promise<void> {
    try {
      const res: any = await this.messageboxService.getDiscussions();
      this.conversations = res.content;
    } catch (error) {
      console.log(error);
    }
  }
}
