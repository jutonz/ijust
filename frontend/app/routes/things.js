import Ember from 'ember';

export default Ember.Route.extend({
  model: function() {
    return this.store.findAll('thing');
  },

  actions: {
    addOccurrence: function(thing) {
      let thingObject = this.store.find('thing', thing.get('id'));
      var occurrence = this.store.createRecord('occurrence', {
        thing: thingObject,
        thing_id: thing.get('id')
      });

      occurrence.save();
    }
  }

});
