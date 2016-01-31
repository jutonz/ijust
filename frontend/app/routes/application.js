import Ember from 'ember';

export default Ember.Route.extend({
  beforeModel: function(transition) {
    let qp = transition.queryParams;
    if (!!qp.content) {
      let appCon = this.controllerFor('application');
      appCon.send('setContent', qp.content);
    }
  }
});
