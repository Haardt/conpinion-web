export class ReduxMixin {

  constructor() {
    this.reducer = [];
    this.subscriber = [];
  }

  addReducer(reducer) {
    this.reducer.push(reducer);
  }

  addSubscriber(subscriber) {
    this.subscriber.push(subscriber);
  }

  createReduxStore() {
    console.log('Reducer:', this.reducer);
    console.log('Subsciber:', this.subscriber);
  }
 }