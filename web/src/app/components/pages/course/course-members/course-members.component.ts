import { Component, OnInit } from '@angular/core';
import { AccountService } from 'src/app/services/account.service';
import { ClassService } from 'src/app/services/class.service';
import { LocalStorageService } from 'src/app/services/local-storage.service';
import { User } from 'src/app/utils/Types';

@Component({
  selector: 'app-course-members',
  templateUrl: './course-members.component.html',
  styleUrls: ['./course-members.component.css'],
})
export class CourseMembersComponent implements OnInit {
  classId: string = '';
  members: User[] = [];
  isProfessor: boolean = false;

  constructor(
    private classService: ClassService,
    private accountService: AccountService,
    private localStorageService: LocalStorageService
  ) {}

  async ngOnInit(): Promise<void> {
    this.classId = history.state.classId;

    try {
      const res: any = await this.classService.getCourseMembers(this.classId);
      for (let user of res) {
        const data: any = await this.accountService.getUser(user.memberID);
        let newUser = data.user;
        newUser.id = user.memberID;
        this.members.push(newUser);
      }

      const res2: any = await this.classService.getCourseForAdmin(this.classId);

      this.isProfessor =
        parseInt(this.localStorageService.get('userId')!) === res2;
    } catch (error) {
      console.log(error);
    }
  }

  addMember(user: User) {
    this.members.push(user);
  }
}
