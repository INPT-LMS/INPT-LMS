import { Component, OnInit } from '@angular/core';
import { AssignmentService } from 'src/app/services/assignment.service';
import { ClassService } from 'src/app/services/class.service';
import { Class, Devoir } from 'src/app/utils/Types';

@Component({
  selector: 'app-course-assignments',
  templateUrl: './course-assignments.component.html',
  styleUrls: ['./course-assignments.component.css'],
})
export class CourseAssignmentsComponent implements OnInit {
  classId: string;
  class: Class;
  devoirs: Devoir[] = [];

  constructor(
    private classService: ClassService,
    private assignmentService: AssignmentService
  ) {
    this.classId = history.state.classId;
    this.class = {};
  }

  async ngOnInit(): Promise<void> {
    const res: any = await this.assignmentService.getDevoirsForClass(
      this.classId
    );
    this.devoirs = res;

    const res2: any = await this.classService.getCourseForAdmin(this.classId);
    console.log(res2);
    this.class = res2;
    console.log(this.class);
  }
}
