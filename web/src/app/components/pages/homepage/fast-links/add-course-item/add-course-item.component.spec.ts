import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AddCourseItemComponent } from './add-course-item.component';

describe('AddCourseItemComponent', () => {
  let component: AddCourseItemComponent;
  let fixture: ComponentFixture<AddCourseItemComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AddCourseItemComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AddCourseItemComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
