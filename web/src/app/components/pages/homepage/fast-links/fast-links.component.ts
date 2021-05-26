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

  async ngOnInit(): Promise<void> {
    try {
      const res: any = await this.classService.getAllStudentCourses();
      if (res) {
        this.courses = res;
      }
    } catch (error) {
      console.log(error);
    }
  }
}
