import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ClassService } from 'src/app/services/class.service';
import { LocalStorageService } from 'src/app/services/local-storage.service';
import { PostService } from 'src/app/services/post.service';
import { Class, Publication } from 'src/app/utils/Types';

@Component({
  selector: 'app-course',
  templateUrl: './course.component.html',
  styleUrls: ['./course.component.css'],
})
export class CourseComponent implements OnInit {
  class: Class;
  posts: Publication[];

  constructor(
    private postService: PostService,
    private classService: ClassService,
    private localStorageService: LocalStorageService,
    private router: Router
  ) {
    this.posts = [];
    this.class = {
      devoirs: [],
    };
  }

  async ngOnInit(): Promise<void> {
    if (!this.localStorageService.get('userToken') || !history.state.class) {
      this.router.navigate(['/']);
    }

    this.class = history.state.class;

    try {
      const res: any = await this.postService.getClassPublications(
        this.class.courseID!
      );
      this.posts = res;
    } catch (error) {
      console.log(error);
    }
  }

  async deleteClass() {
    try {
      const res: any = await this.classService.deleteCourse(
        this.class.courseID!
      );
      if (res === true) {
        this.router.navigate(['/']);
      } else {
        throw 'An error occured';
      }
    } catch (error) {
      console.log(error);
    }
  }
}
