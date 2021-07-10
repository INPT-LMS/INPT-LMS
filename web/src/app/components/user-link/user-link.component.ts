import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-user-link',
  templateUrl: './user-link.component.html',
  styleUrls: ['./user-link.component.css'],
})
export class UserLinkComponent implements OnInit {
  @Input()
  userId: number = -1;

  constructor() {}

  ngOnInit(): void {}
}
