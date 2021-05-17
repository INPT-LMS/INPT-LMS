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
      // TODO Publications d'un cours
      console.log("Publications d'un cours");
      this.postService.getAllPublications().subscribe((response: any) => {
        this.posts = response;
      });
    } else {
      // TODO Publications du feed
      console.log('Publications du feed');
      this.postService.getAllPublications().subscribe((response: any) => {
        this.posts = response;
      });
    }
  }
}
