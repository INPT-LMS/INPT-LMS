import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CourseMembersComponent } from './course-members.component';

describe('CourseMembersComponent', () => {
  let component: CourseMembersComponent;
  let fixture: ComponentFixture<CourseMembersComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CourseMembersComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CourseMembersComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
