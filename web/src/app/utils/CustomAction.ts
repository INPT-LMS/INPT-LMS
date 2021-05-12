import { Action } from '@ngrx/store';

export default interface CustomAction extends Action {
  payload?: any;
}
