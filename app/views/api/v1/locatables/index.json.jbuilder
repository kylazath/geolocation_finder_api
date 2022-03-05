json.data @locatables, partial: 'api/v1/locatables/locatable', as: :locatable

json.links do
  json.self request.original_url
end
