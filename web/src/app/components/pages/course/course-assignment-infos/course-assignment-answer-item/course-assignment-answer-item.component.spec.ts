import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CourseAssignmentAnswerItemComponent } from './course-assignment-answer-item.component';

describe('CourseAssignmentAnswerItemComponent', () => {
  let component: CourseAssignmentAnswerItemComponent;
  let fixture: ComponentFixture<CourseAssignmentAnswerItemComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CourseAssignmentAnswerItemComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CourseAssignmentAnswerItemComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
