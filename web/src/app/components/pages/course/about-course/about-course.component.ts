import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-about-course',
  templateUrl: './about-course.component.html',
  styleUrls: ['./about-course.component.css'],
})
export class AboutCourseComponent implements OnInit {
  @Input()
  about: string;
  constructor() {
    this.about = '';
  }

  ngOnInit(): void {}
}
