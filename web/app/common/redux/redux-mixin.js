import { combineReducers, createStore } from 'redux';

let instance = null;

export class ReduxMixin {

  constructor() {
    if (instance){
      return instance;
    }

    this.reducer = {};
    this.subscribers = [];
    this.store = null;
    instance = this;
  }

  init(){
    this.store = instance.store;
  }

  addReducer(reducerName, reducer) {
    instance.reducer[reducerName] = reducer;
  }

  addSubscriber(subscriber) {
    instance.subscribers.push(() => subscriber(this.getState()));
  }

  dispatch(action) {
    instance.store.dispatch(action);
  }

  createStore() {
    let appReducer = combineReducers(this.reducer);
    instance.store = createStore(appReducer);
    instance.subscribers.forEach((subscriber) => {
        instance.store.subscribe(subscriber);
      });
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