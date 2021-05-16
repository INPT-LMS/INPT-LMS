import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { MessageboxService } from 'src/app/services/messagebox.service';
import { Conversation, User, Message } from 'src/app/utils/Types';

@Component({
  selector: 'app-conversation',
  templateUrl: './conversation.component.html',
  styleUrls: ['./conversation.component.css'],
})
export class ConversationComponent implements OnInit {
  conversation: Conversation;
  otherUser: User;
  messages: Message[];
  messageForm = this.formBuilder.group({
    message: '',
  });

  constructor(
    private router: Router,
    private messageboxService: MessageboxService,
    private formBuilder: FormBuilder
  ) {
    this.router.routeReuseStrategy.shouldReuseRoute = () => false;
    this.conversation = {
      id: '',
      idParticipant1: -1,
      idParticipant2: -1,
    };
    this.otherUser = {};
    this.messages = [];
  }

  ngOnInit(): void {
    if (!history.state.conversation) {
      this.router.navigate(['/messaging']);
    }

    this.conversation = history.state.conversation;
    this.otherUser = history.state.otherUser;

    this.messageboxService
      .getMessages(this.conversation.id)
      .subscribe((res: any) => {
        this.messages = res.content;
      });
  }

  onSubmit(event: Event) {
    event.preventDefault();

    this.messageboxService
      .sendMessage({
        contenu: this.messageForm.value.message,
        idDestinataire: this.otherUser.id!,
      })
      .subscribe((res: any) => {
        console.log(res);
      });
  }
}
