class String
  
  def escape_html_unless_safe
    (self.blank? || self.html_safe?) ? self : CGI::escapeHTML(self)
  end
  
  def escape_html_unless_safe!
    replace CGI::escapeHTML(self) unless self.blank? || self.html_safe?
  end
  
  def wrap_text_at(col = 80)
    self.gsub(/(.{1,#{col}})(?: +|$\n?)|(.{1,#{col}})/, "\\1\\2\n")
  end
  
  # Examples:
  #
  #  "100x200"  => [100, 200]
  #  "10-20x30" => [[10, 20], 30]
  # 
  def to_dimensions
    self.split(/x/).map { |s|
      if s.include?('-')
        s.split(/-/).map { |r| r.to_i }
      else 
        s.to_i
      end 
    } 
  end
  
  def slugize
    str = self
    # Substitute utf-8 characters
    str.gsub!(/\u00AE/, " registered ")
    str.gsub!(/\u00A9/, " copyright ")
    # Transliteration to replace non-ascii with ascii characters
    str = str.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s
    # Remove single quotes from input
    str.gsub!(/[']+/, '')
    # Substitute html characters
    str.gsub!(/&reg;/, " registered ")
    str.gsub!(/&copy;/, " copyright ")
    # Other substitutions
    str.gsub!(/@/, " at ")
    # Replace any non-word character (\W) with a space
    str.gsub!(/\W+/, ' ')
    str.gsub!(/_/, ' ')
    str.squish!
    str.downcase!
    str.gsub(/[\s]/, '-')
  end
  alias_method :to_slug, :slugize

  def is_numeric?
    if self =~ /^\d+$/
      self.to_i
    elsif self =~ /^\d+([,\.]\d+)?$/
      self.tr(',','.').to_f
    else
      false
    end
  end
  
  def blank?
    self !~ /\S/
  end
  
  def any?
    !self.empty?
  end
  
  alias_method :trim, :strip
  alias_method :trim!, :strip!
  
end