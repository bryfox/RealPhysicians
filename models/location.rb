class Location

  include DataMapper::Resource

  has n, :physicians, :through => Resource

  property :id,      Serial
  property :address, Text
  property :city,    Text
  property :country, Text

end