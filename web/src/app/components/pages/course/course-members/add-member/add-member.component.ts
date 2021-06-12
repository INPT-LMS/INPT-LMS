import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { Observable } from 'rxjs';
import {
  debounceTime,
  distinctUntilChanged,
  map,
  switchMap,
} from 'rxjs/operators';
import { AccountService } from 'src/app/services/account.service';
import { ClassService } from 'src/app/services/class.service';
import { User } from 'src/app/utils/Types';

const states = ['test1', 'test2', 'test3'];

@Component({
  selector: 'app-add-member',
  templateUrl: './add-member.component.html',
  styleUrls: ['./add-member.component.css'],
})
export class AddMemberComponent implements OnInit {
  @Input()
  classId: string = '';
  @Input()
  members: User[] = [];
  @Input()
  addMember: (_: User) => void = (user: User) => {};
  addUserForm = this.formBuilder.group({
    userName: '',
  });

  foundUsers: any = [];

  constructor(
    private classService: ClassService,
    private accountService: AccountService,
    private formBuilder: FormBuilder
  ) {}

  ngOnInit(): void {}

  async onSubmit(event: Event) {
    event.preventDefault();

    const { userName } = this.addUserForm.value;
    const user = <any>this.foundUsers.find((user: User) => {
      if (user.fullName == userName) {
        return user;
      } else {
        return null;
      }
    });

    try {
      if (user) {
        const { id: userId } = user;
        const userExists = !!this.members.find(
          (user: User) => user.id === parseInt(userId)
        );
        if (!userExists) {
          const res = await this.classService.addMemberInCourse(
            this.classId,
            userId
          );
          user.nom = user.userInfos.nom;
          user.prenom = user.userInfos.prenom;
          this.addMember(user);
        } else {
          console.log('User is already a member');
        }
      } else {
        console.log('No user found');
      }
    } catch (error) {
      console.log(error);
    }
  }

  search = (text$: Observable<string>) => {
    return text$.pipe(
      debounceTime(200),
      distinctUntilChanged(),
      switchMap(async (term) => {
        if (term.length < 2) {
          return [];
        } else {
          try {
            this.foundUsers = await this.accountService.searchUserByName(
              term.toLowerCase()
            );

            console.log(this.foundUsers);

            const users = <User[]>(
              this.foundUsers.map((user: User) => user.fullName)
            );

            return users;
          } catch (error) {
            console.log('Error' + error);
            return [];
          }
        }
      })
    );
  };
}
