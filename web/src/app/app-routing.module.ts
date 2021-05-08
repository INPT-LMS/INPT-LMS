import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { CourseComponent } from './components/pages/course/course.component';
import { HomepageComponent } from './components/pages/homepage/homepage.component';
import { MessagingComponent } from './components/pages/messaging/messaging.component';

const routes: Routes = [
  { path: '', redirectTo: 'feed', pathMatch: 'full' },
  { path: 'feed', component: HomepageComponent },
  { path: 'course', component: CourseComponent },
  { path: 'messaging', component: MessagingComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule],
})
export class AppRoutingModule {}
