import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { AssignmentService } from 'src/app/services/assignment.service';

@Component({
  selector: 'app-add-assignment',
  templateUrl: './add-assignment.component.html',
  styleUrls: ['./add-assignment.component.css'],
})
export class AddAssignmentComponent implements OnInit {
  @Input()
  classId: string = '';

  assignmentForm = this.formBuilder.group({
    type: 'DEVOIR',
    contenu: '',
    dateLimite: this.initDate(),
  });
  constructor(
    private assignmentService: AssignmentService,
    private formBuilder: FormBuilder
  ) {}

  initDate(): string {
    const d = new Date();
    const year = d.getFullYear();
    const month =
      d.getUTCMonth() + 1 < 10
        ? '0' + (d.getUTCMonth() + 1)
        : d.getUTCMonth() + 1;
    const day = d.getUTCDate();
    return `${year}-${month}-${day}`;
  }

  ngOnInit(): void {}

  async onSubmit(event: Event) {
    event.preventDefault();

    const { contenu, type, dateLimite } = this.assignmentForm.value;

    console.log(this.assignmentForm.value);

    try {
      const res = await this.assignmentService.addDevoir(this.classId, {
        contenu,
        type,
        dateLimite,
      });
      console.log(res);
      if (res === null) {
        console.log("La date doit être supérieure à la date d'aujourd'hui");
      }
    } catch (error) {
      console.log(error);
    }
  }
}
