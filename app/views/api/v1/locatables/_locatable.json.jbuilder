json.type locatable.class.model_name.plural
json.id   locatable.id
json.attributes do
  json.identifiable_by locatable.identifiable_by
  json.longitude       locatable.longitude
  json.latitude        locatable.latitude
end
