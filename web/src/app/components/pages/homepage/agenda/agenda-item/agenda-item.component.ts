import { Component, Input, OnInit } from '@angular/core';
import { Devoir } from 'src/app/utils/Types';

@Component({
  selector: 'app-agenda-item',
  templateUrl: './agenda-item.component.html',
  styleUrls: ['./agenda-item.component.css'],
})
export class AgendaItemComponent implements OnInit {
  @Input()
  devoir: Devoir = {};

  constructor() {}

  ngOnInit(): void {}
}
