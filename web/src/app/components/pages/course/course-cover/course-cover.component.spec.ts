import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CourseCoverComponent } from './course-cover.component';

describe('CourseCoverComponent', () => {
  let component: CourseCoverComponent;
  let fixture: ComponentFixture<CourseCoverComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CourseCoverComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CourseCoverComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
