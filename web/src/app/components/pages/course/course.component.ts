import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { LocalStorageService } from 'src/app/services/local-storage.service';
import { PostService } from 'src/app/services/post.service';
import { Class, Publication } from 'src/app/utils/Types';

@Component({
  selector: 'app-course',
  templateUrl: './course.component.html',
  styleUrls: ['./course.component.css'],
})
export class CourseComponent implements OnInit {
  class: Class;
  posts: Publication[];

  constructor(
    private postService: PostService,
    private localStorageService: LocalStorageService,
    private router: Router
  ) {
    this.posts = [];
    this.class = {
      devoirs: [],
    };
  }

  ngOnInit(): void {
    if (!this.localStorageService.get('userToken') || !history.state.class) {
      this.router.navigate(['/']);
    }

    this.class = history.state.class;
    this.postService
      .getClassPublications(this.class.courseID!)
      .subscribe((response: any) => {
        this.posts = response;
      });
  }
}
