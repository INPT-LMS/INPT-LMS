import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { PostService } from 'src/app/services/post.service';
import { Class, Publication } from 'src/app/utils/Types';
import { CourseComponent } from '../course.component';

@Component({
  selector: 'app-add-post',
  templateUrl: './add-post.component.html',
  styleUrls: ['./add-post.component.css'],
})
export class AddPostComponent implements OnInit {
  @Input()
  class: Class;
  @Input()
  posts: Publication[];

  postForm = this.formBuilder.group({
    content: '',
  });

  constructor(
    private postService: PostService,
    private formBuilder: FormBuilder
  ) {
    this.class = {};
    this.posts = [];
  }

  ngOnInit(): void {
    console.log(this.class);
  }

  onSubmit(event: Event) {
    event.preventDefault();

    const { content } = this.postForm.value;
    const publication: Publication = {
      idCours: this.class.courseID,
      contenuPublication: content,
    };
    console.log(publication);
    this.postService
      .addPublication(publication)
      .subscribe((res: Publication) => {
        console.log(res);
        this.posts.unshift(res);
      });
  }
}
