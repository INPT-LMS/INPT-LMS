import { Component, Input, OnInit, Output } from '@angular/core';
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
  deletePostById: (_: string) => void = (_: string) => {};
  @Input()
  post: Publication;
  user: User;
  class: any;
  myLike?: Like;
  isLiked: boolean;
  myPost: boolean;

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
    this.myPost = false;
  }

  async ngOnInit(): Promise<void> {
    const idProprietaire = this.post.idProprietaire!;
    try {
      const res: any = await this.accountService.getUser(idProprietaire);
      this.user = res.user;
    } catch (error: any) {
      console.log('error:' + error.message);
    }

    const myId = parseInt(this.localStorageService.get('userId')!);
    this.myPost = this.post.idProprietaire === myId;

    this.myLike = this.post.likes?.find((like) => like.idProprietaire == myId);
    this.isLiked = !!this.myLike;
  }

  async like() {
    const idPub = this.post.id;
    try {
      if (!this.isLiked && !this.myLike?.id) {
        const res: any = await this.postService.addLike({
          idPublication: idPub,
        });
        this.myLike = {
          id: res.id,
          dateLike: res.dateLike,
          idProprietaire: res.idProprietaire,
          idPublication: res.idPublication,
        };
        this.post.likes!.push(this.myLike);
        this.isLiked = true;
      } else {
        const res: any = await this.postService.deleteLike(this.myLike!.id!);
        this.post.likes = this.post.likes?.filter((like) => {
          like.id != this.myLike!.id!;
        });
        this.isLiked = false;
        this.myLike = {};
      }
    } catch (error) {
      console.log(error);
    }
  }

  async deletePost() {
    const postId = this.post.id!;
    try {
      const res = await this.postService.deletePublication(postId);
      this.deletePostById(postId);
    } catch (error) {
      // FIXME Le client reçoit une erreur même si la suppression passe quand même
      console.log(error);
    } finally {
      this.deletePostById(postId);
    }
  }

  async onSubmit(event: Event) {
    event.preventDefault();

    const idProprietaire = parseInt(this.localStorageService.get('userId')!);
    const idPublication = this.post.id!;
    const { comment: contenuCommentaire } = this.commentForm.value;

    const payload: Commentaire = {
      idProprietaire,
      idPublication,
      contenuCommentaire,
    };

    try {
      await this.postService.addCommentaire(payload);
      this.post.commentaires?.unshift(payload);
    } catch (error) {
      console.log(error);
    }
  }
}
