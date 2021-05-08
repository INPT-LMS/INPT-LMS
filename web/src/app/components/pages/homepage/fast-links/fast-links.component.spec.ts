import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FastLinksComponent } from './fast-links.component';

describe('FastLinksComponent', () => {
  let component: FastLinksComponent;
  let fixture: ComponentFixture<FastLinksComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ FastLinksComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(FastLinksComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
