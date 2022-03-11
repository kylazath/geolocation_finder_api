require "test_helper"

class Api::V1::LocatablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    # debugger
  end

  test 'index' do
    get api_v1_locatables_url, as: :json
    assert_response 200
  end

  test 'create' do
    stub_ipstack_request
    assert_difference -> { Locatable.count } do
      post api_v1_locatables_url, params: { data: { attributes: { identifiable_by: '98.315.216.278' } } }, as: :json
      assert_response 201
    end
  end

  test 'show' do
    locatable = locatables(:with_uri)
    get api_v1_locatable_url(locatable), as: :json
    assert_includes @response.body, locatable.identifiable_by
    assert_includes @response.body, locatable.longitude
    assert_includes @response.body, locatable.latitude
  end

  test 'update' do
    stub_ipstack_request
    locatable = locatables(:with_ip)
    assert_changes -> { locatable.reload.latitude } do
      patch api_v1_locatable_url(locatable), params: { data: { attributes: { identifiable_by: '98.315.216.278' } } }, as: :json
      assert_response 200
    end
  end

  test 'destroy' do
    assert_difference -> { Locatable.count }, -1 do
      delete api_v1_locatable_url(locatables(:with_uri)), as: :json
      assert_response 204
    end
  end

  private

  def stub_ipstack_request
    stub_request(:get, /ipstack/)
      .to_return(body: {
                   latitude: locatables(:with_uri).latitude,
                   longitude: locatables(:with_uri).longitude
                 }.to_json)
  end
end
