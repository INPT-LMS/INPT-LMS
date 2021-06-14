import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AssignmentService } from 'src/app/services/assignment.service';
import { ClassService } from 'src/app/services/class.service';
import { LocalStorageService } from 'src/app/services/local-storage.service';
import { PostService } from 'src/app/services/post.service';
import { Class, Devoir, Publication } from 'src/app/utils/Types';

@Component({
  selector: 'app-course',
  templateUrl: './course.component.html',
  styleUrls: ['./course.component.css'],
})
export class CourseComponent implements OnInit {
  class: Class;
  posts: Publication[];
  devoirs: Devoir[];
  ownerId: number;

  constructor(
    private postService: PostService,
    private assignmentService: AssignmentService,
    private classService: ClassService,
    private localStorageService: LocalStorageService,
    private router: Router
  ) {
    this.posts = [];
    this.devoirs = [];
    this.class = {
      devoirs: [],
    };
    this.ownerId = -1;
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

      const res2: any = await this.assignmentService.getDevoirsForClass(
        this.class.courseID!
      );
      this.devoirs = res2;
    } catch (error) {
      console.log(error);
    }

    this.ownerId = this.class.owner?.professorID!;
  }

  async deleteClass() {
    try {
      const res: any = await this.classService.deleteCourse(
        this.class.courseID!
      );
      console.log(res);
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
