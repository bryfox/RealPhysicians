class String
  def title_case
    self.gsub(/\b\w/){$&.upcase}
  end
end
