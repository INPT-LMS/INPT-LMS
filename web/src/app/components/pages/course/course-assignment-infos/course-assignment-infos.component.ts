import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
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
  fileToUpload: File | null = null;
  assignmentStatus = {
    rendu: false,
    estNote: false,
    note: 0,
  };

  // assignmentForm = this.formBuilder.group({
  //   fichier: new File(),
  // });

  constructor(
    private router: Router,
    private formBuilder: FormBuilder,
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

    if (this.devoir.reponses!.length === 1) {
      this.assignmentStatus.rendu = true;
      if (this.devoir.reponses![0].estNote) {
        this.assignmentStatus.estNote = this.devoir.reponses![0].estNote;
        this.assignmentStatus.note = this.devoir.reponses![0].note!;
      }
    }
  }

  async onSubmit(event: Event) {
    event.preventDefault();

    try {
      if (this.fileToUpload != null) {
        const res = await this.assignmentService.addRenduDevoir(
          this.classId,
          this.devoirId,
          this.fileToUpload
        );
        console.log(res);

        this.assignmentStatus.rendu = true;
        this.assignmentStatus.note = 0;
      } else {
        console.log('Pas de fichier');
      }
    } catch (error) {
      console.log(error);
    }
  }

  changeFile(event: Event) {
    event.preventDefault();

    const { files } = event.target as any;

    this.fileToUpload = files.item(0);
  }
}
