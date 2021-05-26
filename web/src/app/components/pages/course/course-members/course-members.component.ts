import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-course-members',
  templateUrl: './course-members.component.html',
  styleUrls: ['./course-members.component.css'],
})
export class CourseMembersComponent implements OnInit {
  classId: string = '';

  constructor() {}

  ngOnInit(): void {
    this.classId = history.state.classId;
  }
}
