import { createContext } from 'react';

export const UserContext = createContext();

export const initialState = {
  user: ''
}

export function reducer(state, action) {
  switch (action.type) {
    case 'set user':
      return {
        ...state,
        user: action.payload
      }
    default:
      return state;
  }
}
