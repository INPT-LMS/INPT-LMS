import { Component, Input, OnInit } from '@angular/core';
import { AccountService } from 'src/app/services/account.service';
import { LocalStorageService } from 'src/app/services/local-storage.service';
import { PostService } from 'src/app/services/post.service';
import { Commentaire, User } from 'src/app/utils/Types';

@Component({
  selector: 'app-comment',
  templateUrl: './comment.component.html',
  styleUrls: ['./comment.component.css'],
})
export class CommentComponent implements OnInit {
  @Input()
  commentaire: Commentaire;
  @Input()
  deleteCommentById: (_: string) => void = (_: string) => {};
  user: User;
  isMine: boolean = false;

  constructor(
    private accountService: AccountService,
    private postService: PostService,
    private localStorageService: LocalStorageService
  ) {
    this.commentaire = {
      idPublication: '-1',
      contenuCommentaire: '',
    };
    this.user = {};
  }

  async ngOnInit(): Promise<void> {
    const userId = this.commentaire.idProprietaire!;
    try {
      const res: any = await this.accountService.getUser(userId);
      this.user = res.user;
      this.user.id = userId;
    } catch (error) {
      console.log(error);
    }

    this.isMine = userId === parseInt(this.localStorageService.get('userId')!);
  }

  async deleteComment() {
    const commentId = this.commentaire.id!;

    try {
      const res = await this.postService.deleteCommentaire(commentId);
      console.log(res);
      this.deleteCommentById(commentId);
    } catch (error) {
      console.log(error);
    }
  }
}
