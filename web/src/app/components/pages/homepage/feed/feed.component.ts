import { Component, Input, OnInit } from '@angular/core';
import { PostService } from 'src/app/services/post.service';
import { Class, Publication } from 'src/app/utils/Types';

@Component({
  selector: 'app-feed',
  templateUrl: './feed.component.html',
  styleUrls: ['./feed.component.css'],
})
export class FeedComponent implements OnInit {
  @Input()
  class: Class;
  posts: Publication[];

  constructor(private postService: PostService) {
    this.class = {};
    this.posts = [];
  }

  ngOnInit(): void {
    if (this.class.courseID) {
      console.log("Publications d'un cours");
      this.postService
        .getClassPublications(this.class.courseID)
        .subscribe((response: any) => {
          console.log(response);
          this.posts = response;
        });
    } else {
      console.log('Publications du feed');
      this.postService.getFeedPublications().subscribe((response: any) => {
        // Publications par cours
        const postsByCourses = Object.values(response);

        postsByCourses.forEach((course: any) => {
          course.forEach((post: Publication) => {
            this.posts.push(post);
          });
        });
      });
    }
  }
}
