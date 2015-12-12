import DS from 'ember-data';

export default DS.Model.extend({
  content:    DS.attr(),
  created_at: DS.attr('date'),
  upated_at:  DS.attr('date')
});
