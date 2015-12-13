import Ember from 'ember';

export default Ember.Controller.extend({
  queryParams: ['query'],
  query: '',

  thing: Ember.computed.alias('model'),

  filteredThings: Ember.computed('query', 'model.[]', function() {
    return this.get('model').filter((thing) => {
      let content = thing.get('content');
      let query   = this.get('query');
      return content.indexOf(query) > -1;
    });
  }),

  actions: {
    setQuery: function(query) {
      this.set('query', query);
    }
  }

});
