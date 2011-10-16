class Location

  include DataMapper::Resource
  include DataMapper::GeoKit

  before :save, :geolocate

  has n, :physicians, :through => Resource

  property :id,      Serial
  has_geographic_location :address

  def geolocate
    return if self.address_lat && self.address_lng
    self.address_lat, self.address_lng = geocoder.geocode("#{self.address_city}, #{self.address_country_code}").ll.split(',')
  end
  
  def geocoder
    Geokit::Geocoders::MultiGeocoder
  end

  def self.near description, miles_radius = 5
    if description
      self.all(:address.near => {:origin => description, :distance => miles_radius.to_i.mi})
    else
      self.all
    end
  end

end