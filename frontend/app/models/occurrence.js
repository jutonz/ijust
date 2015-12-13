import DS from 'ember-data';

export default DS.Model.extend({
  thing:      DS.belongsTo('thing'),
  created_at: DS.attr('date'),
  thing_id:   DS.attr('number'),
});
