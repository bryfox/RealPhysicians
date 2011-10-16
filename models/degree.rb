class Degree

  include DataMapper::Resource

  has n, :physicians, :through => Resource

  NAMES = STRINGS['degrees']
  SCHOOLS = STRINGS['schools']

  property :id,     Serial
  property :date, DateTime
  property :name, Enum[*NAMES]
  property :school, Enum[*SCHOOLS]

  def to_s
    self.name + ', ' + self.school
  end

end