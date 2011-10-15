class Degree

  include DataMapper::Resource

  has n, :physicians, :through => Resource

  NAMES = [:MD, :PhD, :ND]
  SCHOOLS = [:'University of Nigeria']

  property :id,     Serial
  property :degree_date, DateTime
  property :degree_name, Flag[*NAMES]
  property :degree_schools, Flag[*SCHOOLS]

end