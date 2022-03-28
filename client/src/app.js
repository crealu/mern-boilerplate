import TheRoutes from './components/TheRoutes';
import { useState, useReducer } from 'react';
import { UserContext, initialState, reducer } from './context/context';

function getSessionStorage(key, defaultState) {
  const item = sessionStorage.getItem(key);
  if (!item) {
    return defaultState;
  }
  return item;
}

const App = () => {
  initialState.user = getSessionStorage('user', null);
  const [state, dispatch] = useReducer(reducer, initialState);

  return (
    <UserContext.Provider value={{state, dispatch}}>
      <TheRoutes />
    </UserContext.Provider>
  )
}

export default App;
