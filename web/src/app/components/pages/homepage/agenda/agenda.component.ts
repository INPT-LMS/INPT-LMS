import { Component, Input, OnInit, Output } from '@angular/core';
import { AssignmentService } from 'src/app/services/assignment.service';
import { Devoir } from 'src/app/utils/Types';

@Component({
  selector: 'app-agenda',
  templateUrl: './agenda.component.html',
  styleUrls: ['./agenda.component.css'],
})
export class AgendaComponent implements OnInit {
  @Input()
  devoirs: Devoir[] = [];

  constructor() {}

  ngOnInit(): void {}
}
