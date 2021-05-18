import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { AccountService } from 'src/app/services/account.service';
import { ClassService } from 'src/app/services/class.service';
import { LocalStorageService } from 'src/app/services/local-storage.service';
import { PostService } from 'src/app/services/post.service';
import { User, Publication, Like, Commentaire } from 'src/app/utils/Types';

@Component({
  selector: 'app-post',
  templateUrl: './post.component.html',
  styleUrls: ['./post.component.css'],
})
export class PostComponent implements OnInit {
  commentForm = this.formBuilder.group({
    comment: '',
  });
  @Input()
  post: Publication;
  user: User;
  class: any;
  myLike?: Like;
  isLiked: boolean;

  constructor(
    private accountService: AccountService,
    private postService: PostService,
    private formBuilder: FormBuilder,
    private localStorageService: LocalStorageService
  ) {
    this.post = {
      id: '',
      likes: [],
      commentaires: [],
    };
    this.user = {};
    this.class = {};
    this.myLike = {};
    this.isLiked = false;
  }

  ngOnInit(): void {
    this.accountService
      .getUser(<number>this.post.idProprietaire)
      .subscribe((res: any) => {
        this.user = res.user;
      });

    const myId = parseInt(this.localStorageService.get('userId')!);
    this.myLike = this.post.likes?.find((like) => like.idProprietaire == myId);
    this.isLiked = !!this.myLike;
  }

  like() {
    const idPub = this.post.id;
    if (!this.isLiked && !this.myLike?.id) {
      this.postService
        .addLike({ idPublication: idPub })
        .subscribe((res: any) => {
          this.myLike = {
            id: res.id,
            dateLike: res.dateLike,
            idProprietaire: res.idProprietaire,
            idPublication: res.idPublication,
          };
          this.post.likes!.push(this.myLike);
          this.isLiked = true;
        });
    } else {
      this.postService.deleteLike(this.myLike!.id!).subscribe((res: any) => {
        this.post.likes = this.post.likes?.filter((like) => {
          like.id != this.myLike!.id!;
        });
        this.isLiked = false;
        this.myLike = {};
      });
    }
    console.log(this.post.likes);
    console.log(this.myLike);
  }

  onSubmit(event: Event) {
    event.preventDefault();

    const idProprietaire = parseInt(this.localStorageService.get('userId')!);
    const idPublication = this.post.id!;
    const { comment: contenuCommentaire } = this.commentForm.value;

    const payload: Commentaire = {
      idProprietaire,
      idPublication,
      contenuCommentaire,
    };

    this.postService.addCommentaire(payload).subscribe((res: any) => {
      this.post.commentaires?.unshift(payload);
    });
  }
}
