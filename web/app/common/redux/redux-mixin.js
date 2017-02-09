import { combineReducers, createStore } from 'redux';

let instance = null;

export class ReduxMixin {

  constructor() {
    if (instance){
      return instance;
    }

    this.reducer = [];
    this.subscriber = [];
    this.store = null;
    instance = this;

  }

  init(){
    console.log('Init called', this);
    this.store = instance.store;
  }

  addReducer(reducer) {
    this.reducer.push(reducer);
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
    console.log(appReducer);
    this.store = createStore(appReducer);
    this.subscriber.forEach ( subscriber => this.store.subscribe(subscriber))
  }

  getState() {
    console.log('getcall')
    return instance.store.getState();
  }

  dumpState() {
    console.log(this.store.getState());
  }
 }