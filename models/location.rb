class Location

  include DataMapper::Resource

  before :save, :geolocate

  has n, :physicians, :through => Resource

  property :id,      Serial
  property :address, Text
  property :city,    Text
  property :country, Text
  property :lat,     String
  property :lng,     String

  def geolocate
    return if self.lat && self.lng
    # puts "#{self.city}, #{self.country}, #{self.lat}, #{self.lng}"
    self.lat, self.lng = geocoder.geocode("#{self.city}, #{self.country}").ll.split(',')
  end
  
  def geocoder
    Geokit::Geocoders::MultiGeocoder
  end

end