import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { ClassService } from 'src/app/services/class.service';

@Component({
  selector: 'app-add-member',
  templateUrl: './add-member.component.html',
  styleUrls: ['./add-member.component.css'],
})
export class AddMemberComponent implements OnInit {
  @Input()
  classId: string = '';
  addUserForm = this.formBuilder.group({
    userId: '',
  });

  constructor(
    private classService: ClassService,
    private formBuilder: FormBuilder
  ) {}

  ngOnInit(): void {}

  async onSubmit(event: Event) {
    event.preventDefault();

    const { userId } = this.addUserForm.value;
    try {
      const res = await this.classService.addMemberInCourse(
        this.classId,
        userId
      );
      console.log(res);
    } catch (error) {
      console.log(error);
    }
  }
}
