import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { PostService } from 'src/app/services/post.service';
import { Publication } from 'src/app/utils/Types';

@Component({
  selector: 'app-add-post',
  templateUrl: './add-post.component.html',
  styleUrls: ['./add-post.component.css'],
})
export class AddPostComponent implements OnInit {
  postForm = this.formBuilder.group({
    content: '',
  });

  constructor(
    private postService: PostService,
    private formBuilder: FormBuilder
  ) {}

  ngOnInit(): void {}

  // TODO Add publication
  onSubmit(event: Event) {
    event.preventDefault();

    const { content } = this.postForm.value;
    const publication: Publication = {
      contenuPublication: content,
    };
    console.log(publication);
    // this.postService.addPublication(publication).subscribe((res: any) => {
    //   console.log(res);
    // });
  }
}
