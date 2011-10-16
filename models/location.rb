class Location

  include DataMapper::Resource
  include DataMapper::GeoKit

  before :save, :geolocate

  has n, :physicians, :through => Resource

  property :id,      Serial
  has_geographic_location :address
  # property :address, Text
  # property :city,    Text
  # property :country, Text
  # property :lat,     String
  # property :lng,     String

  def geolocate
    return if self.address_lat && self.address_lng
    self.address_lat, self.address_lng = geocoder.geocode("#{self.address_city}, #{self.address_country_code}").ll.split(',')
  end
  
  def geocoder
    Geokit::Geocoders::MultiGeocoder
  end

end