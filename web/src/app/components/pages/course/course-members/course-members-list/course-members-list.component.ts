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
  classId: string = '';
  members: User[] = [];

  constructor(
    private classService: ClassService,
    private accountService: AccountService
  ) {}

  async ngOnInit(): Promise<void> {
    try {
      const res: any = await this.classService.getCourseMembers(this.classId);
      for (let user of res) {
        const data: any = await this.accountService.getUser(user.memberID);
        let newUser = data.user;
        newUser.id = user.memberID;
        this.members.push(newUser);
      }
    } catch (error) {
      console.log(error);
    }
  }
}
