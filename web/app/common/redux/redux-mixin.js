import { combineReducers, createStore } from 'redux';

let instance = null;

export class ReduxMixin {

  constructor() {
    if (instance){
      return instance;
    }

    this.reducer = {};
    this.subscriber = [];
    this.store = null;
    instance = this;
  }

  init(){
    this.store = instance.store;
  }

  addReducer(reducerName, reducer) {
    this.reducer[reducerName] = reducer;
  }

  addSubscriber(subscriber) {
    this.subscriber.push(subscriber);
  }

  dispatch(action) {
    instance.store.dispatch(action);
  }

  createStore() {
    console.log('Reducer:', this.reducer);
    console.log('Subsciber:', this.subscriber);

    let appReducer = combineReducers(this.reducer);
    instance.store = createStore(appReducer);
    instance.subscriber.forEach ( subscriber => this.store.subscribe(subscriber))
  }

  getState() {
    return instance.store.getState();
  }

  dumpState() {
    console.log(this.store.getState());
  }
 }