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

  def self.find opts
    # Hourly fee: filter by maximum
    max_fee = opts.delete(:hourly_fee)
    opts.merge!({:hourly_fee.lte => max_fee}) if max_fee
    puts "Query: #{opts.inspect}"
    all(opts)
  end

end