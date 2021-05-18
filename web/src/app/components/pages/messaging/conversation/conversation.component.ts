import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Router } from '@angular/router';
import { MessageboxService } from 'src/app/services/messagebox.service';
import { Conversation, Message } from 'src/app/utils/Types';

@Component({
  selector: 'app-conversation',
  templateUrl: './conversation.component.html',
  styleUrls: ['./conversation.component.css'],
})
export class ConversationComponent implements OnInit {
  conversation: Conversation;
  otherUser: string;
  otherUserId: number;
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
      nomParticipant1: '',
      nomParticipant2: '',
      idParticipant1: -1,
      idParticipant2: -1,
    };
    this.otherUser = '';
    this.otherUserId = -1;
    this.messages = [];
  }

  ngOnInit(): void {
    if (!history.state.conversation) {
      this.router.navigate(['/messaging']);
    }

    this.conversation = history.state.conversation;
    this.otherUser = history.state.otherUser;
    this.otherUserId = history.state.otherUserId;

    this.messageboxService
      .getMessages(this.conversation.id)
      .subscribe((res: any) => {
        this.messages = res.content;
        console.log(this.messages);
        console.log(this.otherUserId);
      });
  }

  onSubmit(event: Event) {
    event.preventDefault();

    const date = new Date();

    const newMessage: Message = {
      contenu: this.messageForm.value.message,
      idDestinataire: this.otherUserId,
      date: date.toString(),
    };

    this.messageboxService.sendMessage(newMessage).subscribe((res: any) => {
      console.log(res);

      this.messages.push(newMessage);

      this.messageForm.reset();
    });
  }
}
