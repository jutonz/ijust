import Ember from 'ember';

export default Ember.Component.extend({
  classNameBindings: ['first'],

  thing: Ember.computed.alias('model'),
  first: Ember.computed.alias('thing.first')
});
