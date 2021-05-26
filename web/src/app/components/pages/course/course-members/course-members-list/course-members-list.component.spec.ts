import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CourseMembersListComponent } from './course-members-list.component';

describe('CourseMembersListComponent', () => {
  let component: CourseMembersListComponent;
  let fixture: ComponentFixture<CourseMembersListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CourseMembersListComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CourseMembersListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
