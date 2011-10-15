class Physician

  include DataMapper::Resource

  SPECIALTIES = STRINGS['specialties']

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

end