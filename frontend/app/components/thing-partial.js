import Ember from 'ember';

export default Ember.Component.extend({
  thing: Ember.computed.alias('model')
});
