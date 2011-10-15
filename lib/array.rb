class Array

  def random
    self[rand(self.size)]
  end

  def symbolize
    self.map {|string| string.to_sym }
  end

end