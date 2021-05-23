import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { ClassService } from 'src/app/services/class.service';
import { Class } from 'src/app/utils/Types';

@Component({
  selector: 'app-add-course-item',
  templateUrl: './add-course-item.component.html',
  styleUrls: ['./add-course-item.component.css'],
})
export class AddCourseItemComponent implements OnInit {
  @Input()
  courses: Class[];

  courseForm = this.formBuilder.group({
    courseName: '',
    courseDescription: '',
    imageURL: '',
  });

  constructor(
    private classService: ClassService,
    private formBuilder: FormBuilder
  ) {
    this.courses = [];
  }

  ngOnInit(): void {}

  async onSubmit(event: Event) {
    event.preventDefault();

    const payload = {
      ...this.courseForm.value,
    };

    try {
      const res: any = await this.classService.addCourseForAdmin(payload);
      this.courses.unshift(payload);
      console.log(res);
    } catch (error) {
      console.log(error);
    }
  }
}
