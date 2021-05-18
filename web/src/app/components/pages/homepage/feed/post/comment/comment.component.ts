import { Component, Input, OnInit } from '@angular/core';
import { AccountService } from 'src/app/services/account.service';
import { Commentaire, User } from 'src/app/utils/Types';

@Component({
  selector: 'app-comment',
  templateUrl: './comment.component.html',
  styleUrls: ['./comment.component.css'],
})
export class CommentComponent implements OnInit {
  @Input()
  commentaire: Commentaire;
  user: User;

  constructor(private accountService: AccountService) {
    this.commentaire = {
      idPublication: '-1',
      contenuCommentaire: '',
    };
    this.user = {};
  }

  ngOnInit(): void {
    const userId = this.commentaire.idProprietaire!;
    this.accountService.getUser(userId).subscribe((res: any) => {
      this.user = res.user;
    });
  }
}
