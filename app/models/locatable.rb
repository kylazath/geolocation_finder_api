class Locatable < ApplicationRecord
  validates :identifiable_by, :latitude, :longitude, presence: true
  validates :latitude, format: { with: /\-?\d{1,2}\.\d+/ }
  validates :longitude, format: { with: /\-?\d{1,3}\.\d+/ }
  validate :identifiable_by_format

  private

  def identifiable_by_format
    unless identifiable_valid_uri? || identifiable_valid_ipv4?
      errors.add(:identifiable_by, :invalid_format)
    end
  end

  def identifiable_valid_uri?
    identifiable_by.match?(URI.regexp)
  end

  def identifiable_valid_ipv4?
    identifiable_by.match?(IPAddr::RE_IPV4ADDRLIKE)
  end
end
