import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { ClassService } from 'src/app/services/class.service';

@Component({
  selector: 'app-add-course-item',
  templateUrl: './add-course-item.component.html',
  styleUrls: ['./add-course-item.component.css'],
})
export class AddCourseItemComponent implements OnInit {
  courseForm = this.formBuilder.group({
    courseName: '',
    courseDescription: '',
    imageURL: '',
  });

  constructor(
    private classService: ClassService,
    private formBuilder: FormBuilder
  ) {}

  ngOnInit(): void {}

  onSubmit(event: Event) {
    event.preventDefault();
    console.log('Form submitted');
    console.log(this.courseForm.value);
    this.classService
      .addCourseForAdmin({
        ...this.courseForm.value,
      })
      .subscribe((res: any) => {
        console.log(res);
      });
  }
}
