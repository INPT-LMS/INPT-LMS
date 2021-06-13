import { Component, Input, OnInit } from '@angular/core';
import { LocalStorageService } from 'src/app/services/local-storage.service';
import { User } from 'src/app/utils/Types';

@Component({
  selector: 'app-course-members-list-item',
  templateUrl: './course-members-list-item.component.html',
  styleUrls: ['./course-members-list-item.component.css'],
})
export class CourseMembersListItemComponent implements OnInit {
  @Input()
  user: User = {};
  @Input()
  ownerId: number = -1;
  isOwner: boolean = false;
  isMe: boolean = false;

  constructor(private localStorageService: LocalStorageService) {}

  ngOnInit(): void {
    this.isOwner = this.user.id === this.ownerId;

    this.isMe =
      parseInt(this.localStorageService.get('userId')!) === this.user.id;
  }
}
