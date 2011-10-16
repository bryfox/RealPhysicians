class Degree

  include DataMapper::Resource

  has n, :physicians, :through => Resource

  NAMES = STRINGS['degrees']
  SCHOOLS = STRINGS['schools']

  property :id,     Serial
  property :degree_date, DateTime
  property :degree_name, Flag[*NAMES]
  property :degree_school, Flag[*SCHOOLS]

end