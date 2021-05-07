import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NavbarComponent } from './components/layout/navbar/navbar.component';
import { FastLinksComponent } from './components/homepage/fast-links/fast-links.component';
import { FeedComponent } from './components/homepage/feed/feed.component';
import { AgendaComponent } from './components/homepage/agenda/agenda.component';
import { LinkItemComponent } from './components/homepage/fast-links/link-item/link-item.component';
import { CommentComponent } from './components/homepage/feed/post/comment/comment.component';
import { PostComponent } from './components/homepage/feed/post/post.component';
import { AgendaItemComponent } from './components/homepage/agenda/agenda-item/agenda-item.component';
import { HomepageComponent } from './components/homepage/homepage.component';
import { CourseComponent } from './components/course/course.component';
import { CourseCoverComponent } from './components/course/course-cover/course-cover.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { AboutCourseComponent } from './components/course/about-course/about-course.component';
import { AddCourseComponent } from './components/course/add-course/add-course.component';

@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    FastLinksComponent,
    FeedComponent,
    AgendaComponent,
    LinkItemComponent,
    CommentComponent,
    PostComponent,
    AgendaItemComponent,
    HomepageComponent,
    CourseComponent,
    CourseCoverComponent,
    AboutCourseComponent,
    AddCourseComponent,
  ],
  imports: [BrowserModule, AppRoutingModule, NgbModule],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
