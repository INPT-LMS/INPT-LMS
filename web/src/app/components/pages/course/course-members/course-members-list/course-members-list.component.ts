import { Component, Input, OnInit, Output } from '@angular/core';
import { ClassService } from 'src/app/services/class.service';
import { User } from 'src/app/utils/Types';

@Component({
  selector: 'app-course-members-list',
  templateUrl: './course-members-list.component.html',
  styleUrls: ['./course-members-list.component.css'],
})
export class CourseMembersListComponent implements OnInit {
  @Input()
  members: User[] = [];
  @Input()
  classId: string = '';
  ownerId: number = -1;

  constructor(private classService: ClassService) {}

  async ngOnInit(): Promise<void> {
    const res: any = await this.classService.getCourseForAdmin(this.classId);
    this.ownerId = res;
  }
}
