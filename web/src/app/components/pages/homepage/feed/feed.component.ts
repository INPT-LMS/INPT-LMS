import { Component, OnInit } from '@angular/core';
import { PostService } from 'src/app/services/post.service';
import { Publication } from 'src/app/utils/Types';

@Component({
  selector: 'app-feed',
  templateUrl: './feed.component.html',
  styleUrls: ['./feed.component.css'],
})
export class FeedComponent implements OnInit {
  posts: Publication[];

  constructor(private postService: PostService) {
    this.posts = [];
  }

  ngOnInit(): void {
    this.postService.getAllPublications().subscribe((response: any) => {
      this.posts = response;
    });
  }
}
