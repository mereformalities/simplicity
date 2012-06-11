class NilClass
  
  def any?
    false
  end
  
  def length
    0
  end
  alias_method :size, :length
  
  def empty?
    true
  end
  alias_method :blank?, :empty?

end