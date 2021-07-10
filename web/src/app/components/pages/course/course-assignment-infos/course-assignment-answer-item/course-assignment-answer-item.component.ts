import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { AccountService } from 'src/app/services/account.service';
import { AssignmentService } from 'src/app/services/assignment.service';
import { StorageService } from 'src/app/services/storage.service';
import { ReponseDevoir, User } from 'src/app/utils/Types';

@Component({
  selector: 'app-course-assignment-answer-item',
  templateUrl: './course-assignment-answer-item.component.html',
  styleUrls: ['./course-assignment-answer-item.component.css'],
})
export class CourseAssignmentAnswerItemComponent implements OnInit {
  @Input()
  reponse: ReponseDevoir = {};
  @Input()
  devoirId: string = '';
  @Input()
  classId: string = '';
  user: User = {};
  noteForm = this.formBuilder.group({
    note: 0,
  });

  constructor(
    private formBuilder: FormBuilder,
    private accountService: AccountService,
    private assignmentService: AssignmentService,
    private storageService: StorageService
  ) {}

  async ngOnInit(): Promise<void> {
    this.noteForm.get('note')?.setValue(this.reponse.note);
    try {
      const res: any = await this.accountService.getUser(
        this.reponse.idProprietaire!
      );
      this.user = res.user;
      console.log(this.user);
    } catch (error) {
      console.log(error);
    }
  }

  async onSubmit(event: Event) {
    event.preventDefault();

    try {
      const res = await this.assignmentService.noteRenduDevoir(
        this.classId,
        this.devoirId,
        this.reponse.id!,
        this.noteForm.value.note
      );

      console.log(res);
    } catch (error) {
      console.log(error);
    }
  }

  async downloadFile() {
    try {
      const res = await this.assignmentService.getUserReponseDevoir(
        this.reponse.idProprietaire!,
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
