import Ember from 'ember';

export default Ember.Controller.extend({
  queryParams: ['content'],
  content: '',
  existingThings: Ember.A(),

  actions: {
    addThing: function(content) {
      let thing = this.get('existingThings.firstObject');
      console.log("would have added:", thing.get('content'));
    },

    setContent: function(content) {
      this.set('content', content);

      if (content === "") {
        // No results if no query
        this.set('existingThings', Ember.A());
      } else {
        this.store.query('thing', { content: content }).then((existing) => {
          this.set('existingThings', existing);
        });
      }
    }
  }
});
