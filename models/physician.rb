class Physician

  include DataMapper::Resource

  SPECIALTIES = STRINGS['specialties'].symbolize!

  has n, :degrees, :through => Resource
  has n, :locations, :through => Resource

  property :id,             Serial
  property :first_name,     Text
  property :last_name,      Text
  property :hourly_fee,     Integer
  property :can_volunteer,  Boolean
  property :specialties,    Flag[*SPECIALTIES]

  def primary_location
    self.locations.first
  end

  def self.find geo, filters
    # Limit to geo, if supplied
    locations = Location.near(geo[:location], geo[:radius]) if geo[:location]

    if filters
      # Hourly fee: filter by maximum
      max_fee = filters.delete(:hourly_fee)
      filters.merge!({:hourly_fee.lte => max_fee}) if max_fee
    end

    if locations
      locations.collect { |loc|  loc.physicians.all(filters) }.flatten.uniq
    else
      self.all(filters)
    end
  end

end