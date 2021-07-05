import { Component, OnInit } from '@angular/core';
import { AssignmentService } from 'src/app/services/assignment.service';
import { Devoir } from 'src/app/utils/Types';

@Component({
  selector: 'app-course-assignments-all',
  templateUrl: './course-assignments-all.component.html',
  styleUrls: ['./course-assignments-all.component.css'],
})
export class CourseAssignmentsAllComponent implements OnInit {
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
