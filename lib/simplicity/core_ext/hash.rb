class Hash
   
 # Create query string from hash params
  def to_query_string
    '?' + self.map { |k,v| "%s=%s" % [CGI::escape(k.to_s), CGI::escape(v.to_s)] }.join('&')
  end
    
end