import { Component, Input, OnInit } from '@angular/core';
import { Class } from 'src/app/utils/Types';

@Component({
  selector: 'app-link-item',
  templateUrl: './link-item.component.html',
  styleUrls: ['./link-item.component.css'],
})
export class LinkItemComponent implements OnInit {
  @Input()
  course: Class;

  constructor() {
    this.course = {};
  }

  ngOnInit(): void {}
}
