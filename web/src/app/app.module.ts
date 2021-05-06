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

@NgModule({
  declarations: [AppComponent, NavbarComponent, FastLinksComponent, FeedComponent, AgendaComponent, LinkItemComponent, CommentComponent, PostComponent, AgendaItemComponent],
  imports: [BrowserModule, AppRoutingModule],
  providers: [],
  bootstrap: [AppComponent],
})
export class AppModule {}
