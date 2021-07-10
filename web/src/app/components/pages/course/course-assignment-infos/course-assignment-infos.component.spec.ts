import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CourseAssignmentInfosComponent } from './course-assignment-infos.component';

describe('CourseAssignmentInfosComponent', () => {
  let component: CourseAssignmentInfosComponent;
  let fixture: ComponentFixture<CourseAssignmentInfosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CourseAssignmentInfosComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CourseAssignmentInfosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
