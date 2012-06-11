class Symbol
  
  def to_slug
    self.to_s.slugize
  end
  alias_method :slugize, :to_slug

end