import { Component, Input, OnInit, Output } from '@angular/core';
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

  async ngOnInit(): Promise<void> {
    console.log(this.posts);
  }

  deletePostById(postId: string) {
    this.posts = this.posts.filter((post) => post.id !== postId);
  }
}
