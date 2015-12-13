import Ember from 'ember';

const { inject, computed } = Ember;

export default Ember.Component.extend({
  thing: computed.alias('model'),
  expanded: false,

  actions: {
    expand: function(thing) {
      thing.toggleProperty('expanded');
    }
  }
});
