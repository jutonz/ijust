import Ember from 'ember';

export default Ember.Route.extend({
  model: function() {
    return this.store.findAll('thing');
  },

  actions: {
    addOccurrence(thing) {
      console.log('adding occurrence to', thing.get('content'));
    }
  }
});
