import { Component, OnInit } from '@angular/core';
import { AssignmentService } from 'src/app/services/assignment.service';
import { ClassService } from 'src/app/services/class.service';
import { LocalStorageService } from 'src/app/services/local-storage.service';
import { Class, Devoir } from 'src/app/utils/Types';

@Component({
  selector: 'app-course-assignments',
  templateUrl: './course-assignments.component.html',
  styleUrls: ['./course-assignments.component.css'],
})
export class CourseAssignmentsComponent implements OnInit {
  classId: string;
  profId: number;
  estProf: boolean;
  devoirs: Devoir[] = [];

  constructor(
    private classService: ClassService,
    private assignmentService: AssignmentService,
    private localStorageService: LocalStorageService
  ) {
    this.classId = history.state.classId;
    this.profId = -1;
    this.estProf = false;
  }

  async ngOnInit(): Promise<void> {
    const res: any = await this.assignmentService.getDevoirsForClass(
      this.classId
    );
    this.devoirs = res;

    const res2: any = await this.classService.getCourseForAdmin(this.classId);
    this.profId = res2;

    this.estProf =
      parseInt(this.localStorageService.get('userId')!) === this.profId;
  }
}
