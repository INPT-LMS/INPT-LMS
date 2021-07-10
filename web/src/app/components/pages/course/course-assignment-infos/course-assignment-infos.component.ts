import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AssignmentService } from 'src/app/services/assignment.service';
import { ClassService } from 'src/app/services/class.service';
import { LocalStorageService } from 'src/app/services/local-storage.service';
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
  profId: number = -1;
  estProf = false;
  fileToUpload: File | null = null;
  assignmentStatus = {
    rendu: false,
    estNote: false,
    note: 0,
  };

  constructor(
    private router: Router,
    private assignmentService: AssignmentService,
    private classService: ClassService,
    private localStorageService: LocalStorageService
  ) {}

  async ngOnInit(): Promise<void> {
    this.router.routeReuseStrategy.shouldReuseRoute = () => false;
    this.devoirId = history.state.devoirId;
    this.classId = history.state.classId;

    const res: any = await this.assignmentService.getDevoir(
      this.classId,
      this.devoirId
    );

    this.devoir = res;
    console.log(this.devoir.reponses);
    if (this.devoir.reponses!.length === 1) {
      this.assignmentStatus.rendu = true;
      if (this.devoir.reponses![0].estNote) {
        this.assignmentStatus.estNote = this.devoir.reponses![0].estNote;
        this.assignmentStatus.note = this.devoir.reponses![0].note!;
      }
    }

    const res2: any = await this.classService.getCourseForAdmin(this.classId);
    this.profId = res2;

    this.estProf =
      parseInt(this.localStorageService.get('userId')!) === this.profId;
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
        this.assignmentStatus.estNote = false;
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

  async downloadFile() {
    try {
      const res = await this.assignmentService.getOwnReponseDevoir(
        this.classId,
        this.devoirId
      );
      const downloadURL = URL.createObjectURL(res);
      window.open(downloadURL);
    } catch (error) {
      console.log(error);
    }
  }
}
