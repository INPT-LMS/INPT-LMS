import { Component, Input, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AccountService } from 'src/app/services/account.service';
import { User } from 'src/app/utils/Types';

@Component({
  selector: 'app-user',
  templateUrl: './user.component.html',
  styleUrls: ['./user.component.css'],
})
export class UserComponent implements OnInit {
  @Input()
  user: User = {};
  constructor(private accountService: AccountService, private router: Router) {}

  async ngOnInit(): Promise<void> {
    const userId = parseInt(this.router.url.split('/').slice(-1)[0]);

    // Pas d'utilisateur dans le link, on retourne au feed
    if (isNaN(userId)) {
      this.router.navigate(['/']);
    }

    try {
      const res: any = await this.accountService.getUser(userId);
      this.user = res.user;
      this.user.id = userId;
    } catch (error) {
      console.log(error);
    }

    console.log(this.user);
  }
}
