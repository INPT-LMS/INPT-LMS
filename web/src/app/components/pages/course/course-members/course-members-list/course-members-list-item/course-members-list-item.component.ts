import { Component, Input, OnInit } from '@angular/core';
import { User } from 'src/app/utils/Types';

@Component({
  selector: 'app-course-members-list-item',
  templateUrl: './course-members-list-item.component.html',
  styleUrls: ['./course-members-list-item.component.css'],
})
export class CourseMembersListItemComponent implements OnInit {
  @Input()
  user: User = {};

  constructor() {}

  ngOnInit(): void {}
}
