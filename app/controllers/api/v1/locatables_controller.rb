class Api::V1::LocatablesController < ApplicationController
  rescue_from ActiveRecord::ConnectionNotEstablished, with: :return_service_unavailable
  rescue_from Apis::IpStack::Requester::RequestError, with: :return_service_unavailable
  rescue_from ActiveRecord::RecordInvalid, with: :return_forbidden

  before_action :accept_only_json_format
  before_action :set_locatable, only: [:show, :update, :destroy]

  def index
    @locatables = Locatable.all
  end

  def create
    @locatable = Locatable.new(locatable_params)
    @locatable.attributes = @locatable.attributes.merge(fetched_geolocation_attributes)
    @locatable.save!
    render(status: :created, location: api_v1_locatable_url(@locatable))
  end

  def show; end

  def update
    @locatable.attributes = locatable_params.merge(fetched_geolocation_attributes)
    @locatable.save!
    render(status: :ok)
  end

  def destroy
    @locatable.destroy!
    head(:no_content)
  end

  private

  def return_service_unavailable
    head(:service_unavailable)
  end

  def return_forbidden
    head(:forbidden)
  end

  def accept_only_json_format
    head(:not_acceptable) unless request.headers['Content-Type'] == 'application/json'
  end

  def set_locatable
    @locatable = Locatable.find_by(id: params[:id])
    head(:not_found) unless @locatable
  end

  def locatable_params
    params.require(:data).require(:attributes).permit(:identifiable_by)
  end

  def fetched_geolocation_attributes
    ::Apis::IpStack::Requester.geolocation_for(@locatable.identifiable_by)
  end
end
