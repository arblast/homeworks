import React from 'react';
import ReactDOM from 'react-dom';

import Note from './util/note.js';

import configureStore from './store/store';
import Root from './components/root';

const addLoggingToDispatch = store => next => action  => {
  console.log(store.getState());
  console.log(action);
  let result = next(action);
  console.log(store.getState());
  return result;
}

const applyMiddlewares = (store, ...middlewares) => {
  let dispatch = store.dispatch;
  middlewares.forEach( mw => {
    dispatch = mw(store)(dispatch);
  })
  return Object.assign({}, store, { dispatch })
}

document.addEventListener('DOMContentLoaded', () => {
  let store = configureStore();
  store = applyMiddlewares(store, addLoggingToDispatch);
  const rootEl = document.getElementById('root');
  ReactDOM.render(<Root store={store} />, rootEl);
});
