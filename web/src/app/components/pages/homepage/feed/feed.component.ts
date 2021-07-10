import { Component, Input, OnInit } from '@angular/core';
import { Class, Publication } from 'src/app/utils/Types';

@Component({
  selector: 'app-feed',
  templateUrl: './feed.component.html',
  styleUrls: ['./feed.component.css'],
})
export class FeedComponent implements OnInit {
  @Input()
  class: Class;
  @Input()
  posts: Publication[] = [];

  constructor() {
    this.class = {};
  }

  async ngOnInit(): Promise<void> {}

  deletePostById(postId: string) {
    this.posts = this.posts.filter((post) => post.id !== postId);
  }
}
