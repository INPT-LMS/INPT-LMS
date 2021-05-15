import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AccountComponent } from './components/pages/account/account.component';
import { LanguageComponent } from './components/pages/account/chosen-setting/language/language.component';
import { PersonalInformationComponent } from './components/pages/account/chosen-setting/personal-information/personal-information.component';
import { SecurityComponent } from './components/pages/account/chosen-setting/security/security.component';
import { CourseComponent } from './components/pages/course/course.component';
import { HomepageComponent } from './components/pages/homepage/homepage.component';
import { LoginComponent } from './components/pages/login/login.component';
import { MessagingComponent } from './components/pages/messaging/messaging.component';
import { SignupComponent } from './components/pages/signup/signup.component';

const routes: Routes = [
  { path: '', redirectTo: 'login', pathMatch: 'full' },
  { path: 'login', component: LoginComponent },
  { path: 'feed', component: HomepageComponent },
  { path: 'signup', component: SignupComponent },
  { path: 'course/:id', component: CourseComponent },
  { path: 'messaging', component: MessagingComponent },
  {
    path: 'account',
    component: AccountComponent,
    children: [
      { path: '', redirectTo: 'personal-information', pathMatch: 'full' },
      { path: 'personal-information', component: PersonalInformationComponent },
      { path: 'language', component: LanguageComponent },
      { path: 'security', component: SecurityComponent },
    ],
  },
  { path: '**', redirectTo: 'feed' },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
