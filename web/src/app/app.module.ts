import { ErrorHandler, NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NavbarComponent } from './components/layout/navbar/navbar.component';
import { FastLinksComponent } from './components/pages/homepage/fast-links/fast-links.component';
import { FeedComponent } from './components/pages/homepage/feed/feed.component';
import { AgendaComponent } from './components/pages/homepage/agenda/agenda.component';
import { LinkItemComponent } from './components/pages/homepage/fast-links/link-item/link-item.component';
import { CommentComponent } from './components/pages/homepage/feed/post/comment/comment.component';
import { PostComponent } from './components/pages/homepage/feed/post/post.component';
import { AgendaItemComponent } from './components/pages/homepage/agenda/agenda-item/agenda-item.component';
import { HomepageComponent } from './components/pages/homepage/homepage.component';
import { CourseComponent } from './components/pages/course/course.component';
import { CourseCoverComponent } from './components/pages/course/course-cover/course-cover.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { AboutCourseComponent } from './components/pages/course/about-course/about-course.component';
import { AddCourseComponent } from './components/pages/course/add-course/add-course.component';
import { MessagingComponent } from './components/pages/messaging/messaging.component';
import { MessagesComponent } from './components/pages/messaging/messages/messages.component';
import { ConversationComponent } from './components/pages/messaging/conversation/conversation.component';
import { FooterComponent } from './components/layout/footer/footer.component';
import { AccountComponent } from './components/pages/account/account.component';
import { SettingsComponent } from './components/pages/account/settings/settings.component';
import { PersonalInformationComponent } from './components/pages/account/chosen-setting/personal-information/personal-information.component';
import { SecurityComponent } from './components/pages/account/chosen-setting/security/security.component';
import { LanguageComponent } from './components/pages/account/chosen-setting/language/language.component';
import { SignupComponent } from './components/pages/signup/signup.component';
import { SignupFormComponent } from './components/pages/signup/signup-form/signup-form.component';
import { LoginComponent } from './components/pages/login/login.component';
import { LoginFormComponent } from './components/pages/login/login-form/login-form.component';
import { HttpClientModule, HTTP_INTERCEPTORS } from '@angular/common/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { ApiInterceptor } from './utils/api.interceptor';
import { MyErrorsHandler } from './utils/myerrorshandler';

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
    MessagingComponent,
    MessagesComponent,
    ConversationComponent,
    FooterComponent,
    AccountComponent,
    SettingsComponent,
    PersonalInformationComponent,
    SecurityComponent,
    LanguageComponent,
    SignupComponent,
    SignupFormComponent,
    LoginComponent,
    LoginFormComponent,
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    NgbModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule,
  ],
  providers: [
    {
      provide: HTTP_INTERCEPTORS,
      useClass: ApiInterceptor,
      multi: true,
    },
    {
      provide: ErrorHandler,
      useClass: MyErrorsHandler,
    },
  ],
  bootstrap: [AppComponent],
})
export class AppModule {}
