import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-course-cover',
  templateUrl: './course-cover.component.html',
  styleUrls: ['./course-cover.component.css'],
})
export class CourseCoverComponent implements OnInit {
  @Input()
  deleteClass: () => void = () => {};
  @Input()
  classId: string;
  @Input()
  title: string;

  constructor() {
    this.classId = '';
    this.title = '';
  }

  ngOnInit(): void {}
}
