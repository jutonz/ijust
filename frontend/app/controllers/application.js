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

      if (existingThing) {
        // Add occurrence to exising thing
        let thingId = existingThing.get('id');
        let occurrence = this.store.createRecord('occurrence', {
          thing_id: thingId,
        });

        occurrence.save();
      } else {
        // Create new thing
        let content = this.get('content');
        let newThing = this.store.createRecord('thing', {
          content: content
        });

        newThing.save().then(() => {
          // Trigger re-render so you see your shiney new thing
          this.send('setContent', content);
        });
      }
    },

    setContent: function(content) {
      this.set('content', content);

      if (content === "") {
        // No results if no query
        this.set('existingThings', Ember.A());
      } else {
        // Clear first property on existing results
        let firstExstingThing = this.get('existingThings.firstObject');
        if (firstExstingThing) {
          firstExstingThing.set('first', false);
        }

        this.store.query('thing', { content: content }).then((existing) => {
          this.set('existingThings', existing);
          let firstExistingThing = this.get('existingThings.firstObject');
          if (firstExistingThing) {
            firstExistingThing.set('first', true);
          }
        });
      }
    }
  }
});
