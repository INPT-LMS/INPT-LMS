import { Component, OnInit } from '@angular/core';
import { ClassService } from 'src/app/services/class.service';
import { Class } from 'src/app/utils/Types';

@Component({
  selector: 'app-fast-links',
  templateUrl: './fast-links.component.html',
  styleUrls: ['./fast-links.component.css'],
})
export class FastLinksComponent implements OnInit {
  courses: Class[];

  constructor(private classService: ClassService) {
    this.courses = [];
  }

  ngOnInit(): void {
    this.classService.getAllStudentCourses().subscribe((res: any) => {
      // console.log(res);
      this.courses = res;
    });
  }
}
