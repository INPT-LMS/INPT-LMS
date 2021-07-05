import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CourseAssignmentsAllComponent } from './course-assignments-all.component';

describe('CourseAssignmentsAllComponent', () => {
  let component: CourseAssignmentsAllComponent;
  let fixture: ComponentFixture<CourseAssignmentsAllComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CourseAssignmentsAllComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CourseAssignmentsAllComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
