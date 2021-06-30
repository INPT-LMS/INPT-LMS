import { Component, OnInit } from '@angular/core';
import { AssignmentService } from 'src/app/services/assignment.service';
import { Devoir } from 'src/app/utils/Types';

@Component({
  selector: 'app-course-assignments',
  templateUrl: './course-assignments.component.html',
  styleUrls: ['./course-assignments.component.css'],
})
export class CourseAssignmentsComponent implements OnInit {
  classId: string;
  devoirs: Devoir[] = [];

  constructor(private assignmentService: AssignmentService) {
    this.classId = history.state.classId;
  }

  async ngOnInit(): Promise<void> {
    const res: any = await this.assignmentService.getDevoirsForClass(
      this.classId
    );

    this.devoirs = res;
  }
}
