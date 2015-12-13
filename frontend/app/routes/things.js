import Ember from 'ember';

export default Ember.Route.extend({
  model: function() {
    return this.store.findAll('thing');
  },

  actions: {
    addOccurrence: function(thing) {
      console.log("hello from the route");
      console.log('adding occurrence to', thing.get('content'), 'with id', thing.get('id'));
      var occurrence = this.store.createRecord('occurrence', {
        thing_id: thing.get('id')
      });

      occurrence.save();
    }
  }

});
