require "test_helper"

class LocatableTest < ActiveSupport::TestCase
  setup do
    @locatable = locatables(:with_uri)
  end

  test 'valid locatable' do
    assert @locatable.valid?
  end

  test 'invalid without identifiable_by' do
    @locatable.identifiable_by = ''
    refute @locatable.valid?
  end

  test 'invalid without latitude' do
    @locatable.latitude = ''
    refute @locatable.valid?
  end

  test 'invalid without valid latitude' do
    @locatable.latitude = '123abc'
    refute @locatable.valid?
  end

  test 'invalid without longitude' do
    @locatable.longitude = ''
    refute @locatable.valid?
  end

  test 'invalid without valid longitude' do
    @locatable.longitude = '321abc'
    refute @locatable.valid?
  end

  test 'invalid without valid identifiable_by' do
    @locatable.identifiable_by = '123abc'
    refute @locatable.valid?
  end
end
