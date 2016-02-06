import Ember from 'ember';

export default Ember.Controller.extend({
  queryParams: ['content'],
  content: '',
  existingThings: Ember.A(),

  actions: {
    addThing: function() {
      // If there were search results, add an occurrence to the first result.
      // Otherwise, create a new thing with the given content.
      let existingThing = this.get('existingThings.firstObject');
      let content = "";

      if (existingThing) {
        // Add occurrence to exising thing
        content = existingThing.get('content');
        console.log('adding occurrence to existing thing with content:', content);

        let thingId = existingThing.get('id');
        let occurrence = this.store.createRecord('occurrence', {
          thing_id: thingId,
        });

        occurrence.save().then(() => {
          console.log('acced occurrence!');
          this.set('content', '')
        });
      } else {
        // Create new thing
        content = this.get('content');
        console.log('creating new thing with content:', content);
        let newThing = this.store.createRecord('thing', {
          content: this.get('content')
        });

        newThing.save().then(() => {
          this.set('content', '');
        });
      }
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
