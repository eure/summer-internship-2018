import { Injectable } from '@angular/core';
import { Http, Headers } from '@angular/http';
import 'rxjs/add/operator/map';

@Injectable()
export class GithubService{
  private username = 'kuwa987';
  private client_id = '14040eb8b3ab2c54e4e6';
  private client_secret = '5dbb79449ef8ac3384f31533c704222ff31f126b';

  constructor(private _http:Http){
    console.log("github service init...");
  }

  getUser(){
    return this._http.get('https://api.github.com/users/' + this.username)
        .map(res => res.json());
  }

  getRepos(){
    return this._http.get('https://api.github.com/users/' + this.username + '/repos')
        .map(res => res.json());
  }

  updateUsername(username:string){
    this.username = username;
  }
}
