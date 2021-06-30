import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { logging } from 'protractor';
import { AssignmentService } from 'src/app/services/assignment.service';
import { Devoir } from 'src/app/utils/Types';

@Component({
  selector: 'app-course-assignment-infos',
  templateUrl: './course-assignment-infos.component.html',
  styleUrls: ['./course-assignment-infos.component.css'],
})
export class CourseAssignmentInfosComponent implements OnInit {
  classId: string = '';
  devoirId: string = '';
  devoir: Devoir = {};

  constructor(
    private router: Router,
    private assignmentService: AssignmentService
  ) {}

  async ngOnInit(): Promise<void> {
    this.router.routeReuseStrategy.shouldReuseRoute = () => false;
    this.devoirId = history.state.devoirId;
    this.classId = history.state.classId;

    console.log(this.classId);

    const res: any = await this.assignmentService.getDevoir(
      this.classId,
      this.devoirId
    );

    this.devoir = res;
    console.log(res);
  }
}
