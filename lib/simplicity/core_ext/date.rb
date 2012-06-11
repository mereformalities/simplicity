class Date
  
  def first_day_of_month
    Date.new(self.year, self.month, 1)
  end
  
  def last_day_of_month
    Date.new(self.year, self.month + 1, 1) - 1
  end
  
  def middle_of_month
    d = (last_day_of_month.day / 2.0).ceil
    Date.new(self.year, self.month, d)
  end
  
  # UNIX timestamp
  def timestamp
    self.to_time.to_i
  end
  
end