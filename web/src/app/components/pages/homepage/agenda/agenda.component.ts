import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-agenda',
  templateUrl: './agenda.component.html',
  styleUrls: ['./agenda.component.css'],
})
export class AgendaComponent implements OnInit {
  @Input()
  devoirs: any[];

  constructor() {
    this.devoirs = [];
  }

  ngOnInit(): void {}
}
