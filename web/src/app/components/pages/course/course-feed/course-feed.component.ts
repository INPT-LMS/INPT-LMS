import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { LocalStorageService } from 'src/app/services/local-storage.service';
import { PostService } from 'src/app/services/post.service';
import { Class, Publication } from 'src/app/utils/Types';

@Component({
  selector: 'app-course-feed',
  templateUrl: './course-feed.component.html',
  styleUrls: ['./course-feed.component.css'],
})
export class CourseFeedComponent implements OnInit {
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

  async ngOnInit(): Promise<void> {
    if (!this.localStorageService.get('userToken') || !history.state.class) {
      this.router.navigate(['/']);
    }

    this.class = history.state.class;

    try {
      const res: any = await this.postService.getClassPublications(
        this.class.courseID!
      );
      this.posts = res;
    } catch (error) {
      console.log(error);
    }
  }
}
