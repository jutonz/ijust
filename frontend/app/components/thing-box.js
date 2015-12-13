import Ember from 'ember';

const { inject, computed } = Ember;

export default Ember.Component.extend({
  thing: computed.alias('model'),
  expanded: false,

  actions: {
    expand: function(thing) {
      thing.toggleProperty('expanded');
    },

    addOccurrence: function(thing) {
      console.log('stage 1');
      this.sendAction('addOccurrence', thing);
    }
  }
});
