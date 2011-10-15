class Doctor

  include DataMapper::Resource

  property :id,     Serial
  property :author, Text

end