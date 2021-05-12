import { LOGIN_USER, LOGOUT_USER, USER_ERROR } from '../actiontypes/types';
import Action from '../utils/CustomAction';
import { User } from '../utils/Types';

interface State {
  user: User;
  error: string;
  loading: boolean;
}

const initialState: State = {
  user: { id: -1, email: '' },
  error: '',
  loading: true,
};

export default function reducer(
  state: State = initialState,
  action: Action
): State {
  console.log(action.type, state);

  const { type, payload } = action;

  switch (type) {
    // TODO Update state
    case LOGIN_USER:
      const { id, email } = payload;
      return {
        ...state,
        error: '',
        loading: false,
        user: { ...state.user, id: id, email: email },
      };
    case LOGOUT_USER:
      return {
        ...state,
        error: '',
        loading: false,
        user: { id: -1 },
      };
    case USER_ERROR:
      return {
        ...state,
        error: payload,
        loading: true,
        user: { id: -1 },
      };
    default:
      return state;
  }
}
