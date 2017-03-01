import { combineReducers, createStore, applyMiddleware } from 'redux';

let instance = null;

export class ReduxMixin {

  constructor() {
    if (instance){
      return instance;
    }

    this.reducer = {};
    this.subscribers = [];
    this.middleware = [];
    this.store = null;
    instance = this;
  }

  init(){
    this.store = instance.store;
  }

  addReducer(reducerName, reducer) {
    instance.reducer[reducerName] = reducer;
    console.log ('Reducer added: ', reducerName);
  }

  addSubscriber(subscriber) {
    instance.subscribers.push(() => subscriber(this.getState()));
  }

  addMiddleware(middleware) {
    instance.middleware.push(middleware);
  }

  dispatch(action) {
    console.log('Before dispatch: ', action.type);
    instance.store.dispatch(action);
  }

  createStore() {
    let appReducer = combineReducers(this.reducer);
    instance.store = createStore(appReducer, applyMiddleware.apply(null, this.middleware));
    instance.subscribers.forEach((subscriber) => {
        instance.store.subscribe(subscriber);
      });
    console.log("Store created.");
  }


  getState() {
    return instance.store.getState();
  }

  createReducer (initState, handlers, getStateSlice) {
    return (state = initState, action) => {
      if (handlers.hasOwnProperty(action.type)) {
        return handlers[action.type](state, action, (getStateSlice || (()=>{})) (this.getState()));
      } else {
        return state;
      }
    }
  }

  dumpState() {
    console.log(this.store.getState());
  }
 }