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
  post: Publication;
  user: User;
  class: any;
  myLike: {
    id: string;
    isLiked: boolean;
  } = {
    id: '',
    isLiked: false,
  };

  constructor(
    private accountService: AccountService,
    private classService: ClassService,
    private postService: PostService
  ) {
    this.post = {
      likes: [],
      commentaires: [],
    };
    this.user = {};
    this.class = {};
  }

  ngOnInit(): void {
    this.accountService
      .getUser(<number>this.post.idProprietaire)
      .subscribe((res: any) => {
        this.user = res.user;
      });
    this.classService
      .getCourse(<string>this.post.idCours)
      .subscribe((res: any) => {
        console.log(res);
        // this.user = res.user;
      });
    this.myLike.isLiked = !!this.post.likes?.find(
      (like) => like.idProprietaire == this.user.id
    );
  }

  like() {
    const idPub = <string>this.post.idPublication;
    if (!this.myLike.isLiked) {
      this.postService
        .addLike({ idPublication: idPub })
        .subscribe((res: any) => {
          console.log(res);
          // TODO Vérifier les champs des likes
          const like: Like = {
            idPublication: idPub,
          };
          this.post.likes!.push(like);
        });
    } else {
      this.postService.deleteLike(this.myLike.id).subscribe((res: any) => {
        console.log(res);
      });
    }
  }

  comment() {
    this.postService
      .addCommentaire({
        contenu: '',
        idPublication: <string>this.post.idPublication,
      })
      .subscribe((res: any) => {
        console.log(res);
      });
  }
}
