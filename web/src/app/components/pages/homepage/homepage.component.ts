import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { LocalStorageService } from 'src/app/services/local-storage.service';
import { PostService } from 'src/app/services/post.service';
import { Publication } from 'src/app/utils/Types';

@Component({
  selector: 'app-homepage',
  templateUrl: './homepage.component.html',
  styleUrls: ['./homepage.component.css'],
})
export class HomepageComponent implements OnInit {
  posts: Publication[];

  constructor(
    private postService: PostService,
    private localStorageService: LocalStorageService,
    private router: Router
  ) {
    this.posts = [];
  }

  async ngOnInit(): Promise<void> {
    if (!this.localStorageService.get('userToken')) {
      this.router.navigate(['/']);
    }

    try {
      const res = await this.postService.getFeedPublications();
      const postsByCourses = Object.values(res);

      postsByCourses.forEach((course: any) => {
        course.forEach((post: Publication) => {
          this.posts.push(post);
        });
      });
    } catch (error) {
      console.log(error);
    }
  }
}
