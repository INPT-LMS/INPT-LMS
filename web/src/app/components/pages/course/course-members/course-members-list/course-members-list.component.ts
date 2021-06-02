import { Component, Input, OnInit } from '@angular/core';
import { AccountService } from 'src/app/services/account.service';
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

  constructor() {}

  async ngOnInit(): Promise<void> {}
}
