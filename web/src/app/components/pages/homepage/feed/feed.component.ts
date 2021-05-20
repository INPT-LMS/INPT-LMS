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
  @Input()
  posts: Publication[];

  constructor() {
    this.class = {};
    this.posts = [];
  }

  ngOnInit(): void {}
}
