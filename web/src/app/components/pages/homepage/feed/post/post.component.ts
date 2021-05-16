import { Component, Input, OnInit } from '@angular/core';
import { AccountService } from 'src/app/services/account.service';
import { ClassService } from 'src/app/services/class.service';
import { PostService } from 'src/app/services/post.service';
import { User, Publication, Like } from 'src/app/utils/Types';

@Component({
  selector: 'app-post',
  templateUrl: './post.component.html',
  styleUrls: ['./post.component.css'],
})
export class PostComponent implements OnInit {
  @Input()
  public post: Publication;
  user: User;
  class: any;
  myLike: Like;

  constructor(
    private accountService: AccountService,
    private postService: PostService
  ) {
    this.post = {
      likes: [],
      commentaires: [],
    };
    this.user = {};
    this.class = {};
    this.myLike = {};
  }

  ngOnInit(): void {
    this.accountService
      .getUser(<number>this.post.idProprietaire)
      .subscribe((res: any) => {
        this.user = res.user;
      });

    // this.classService
    //   .getCourse(<string>this.post.idCours)
    //   .subscribe((res: any) => {
    //     console.log(res);
    //     // this.user = res.user;
    //   });
    const like = this.post.likes?.find(
      (like) => like.idProprietaire == this.user.id
    );

    if (like) {
      this.myLike = like;

      // console.log('my like', this.myLike);
    }
  }

  like() {
    const idPub = this.post.id;
    if (!idPub) {
      // TODO Une erreur à gérer ici
      return;
    }
    if (!this.myLike.idLike) {
      this.postService
        .addLike({ idPublication: idPub })
        .subscribe((res: any) => {
          // console.log(res);
          // TODO Vérifier les champs des likes
          const like: Like = {
            idPublication: idPub,
          };
          this.post.likes!.push(like);
          this.myLike = {};
        });
    } else {
      this.postService.deleteLike(this.myLike.idLike).subscribe((res: any) => {
        // console.log(res);
        this.myLike = {};
      });
    }
  }

  comment() {
    if (!this.post.id) {
      // TODO Une erreur à gérer ici
      return;
    }
    this.postService
      .addCommentaire({
        contenu: '',
        idPublication: this.post.id,
      })
      .subscribe((res: any) => {
        // console.log(res);
      });
  }
}
