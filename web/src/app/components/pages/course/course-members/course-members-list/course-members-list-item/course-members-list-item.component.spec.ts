import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CourseMembersListItemComponent } from './course-members-list-item.component';

describe('CourseMembersListItemComponent', () => {
  let component: CourseMembersListItemComponent;
  let fixture: ComponentFixture<CourseMembersListItemComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CourseMembersListItemComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CourseMembersListItemComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
