json.data @locatable, partial: 'api/v1/locatables/locatable', as: :locatable

json.links do
  json.self api_v1_locatable_url(@locatable)
end
