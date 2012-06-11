class Numeric
  
  def ordinal
    cardinal = self.to_i.abs
    if (10...20).include?(cardinal % 100) then
      cardinal.to_s << 'th'
    else
      cardinal.to_s << %w(th st nd rd th th th th th th)[cardinal % 10]
    end
  end
  
  def clip(lower, upper = nil)
    return lower if self < lower
    return self unless upper
    return upper if self > upper
    return self
  end
  alias_method :bound, :clip
  
end