import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { AccountService } from 'src/app/services/account.service';
import { ClassService } from 'src/app/services/class.service';
import { User } from 'src/app/utils/Types';

@Component({
  selector: 'app-add-member',
  templateUrl: './add-member.component.html',
  styleUrls: ['./add-member.component.css'],
})
export class AddMemberComponent implements OnInit {
  @Input()
  classId: string = '';
  @Input()
  addMember: (_: User) => void = (user: User) => {};
  addUserForm = this.formBuilder.group({
    userId: '',
  });

  constructor(
    private classService: ClassService,
    private accountService: AccountService,
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
      const res2: any = await this.accountService.getUser(userId);
      const { user } = res2;
      this.addMember(user);
    } catch (error) {
      console.log(error);
    }
  }
}
