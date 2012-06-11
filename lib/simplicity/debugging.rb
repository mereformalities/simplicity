module Simplicity
  module Debugging

    protected

    # Debugging messages that are easy to find in the log
    def console(message)
      Rails.logger.debug "[DEBUG] ==> #{message}"
    end

    # http://www.geisterstunde.org/wordpress/?p=198
    def firebug(message, type = :debug)
      request.env['firebug.logs'] ||= []
      request.env['firebug.logs'] << [type.to_sym, message.to_s]
    end

  end
end