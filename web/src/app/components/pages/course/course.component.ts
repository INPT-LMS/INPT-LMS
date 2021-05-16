import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { LocalStorageService } from 'src/app/services/local-storage.service';
import { Class } from 'src/app/utils/Types';

@Component({
  selector: 'app-course',
  templateUrl: './course.component.html',
  styleUrls: ['./course.component.css'],
})
export class CourseComponent implements OnInit {
  class: Class;

  constructor(
    private localStorageService: LocalStorageService,
    private router: Router
  ) {
    this.class = {
      devoirs: [],
    };
  }

  ngOnInit(): void {
    if (!this.localStorageService.get('userToken') || !history.state.class) {
      this.router.navigate(['/']);
    }

    this.class = history.state.class;
  }
}
