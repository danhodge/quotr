require 'net/http'

module Quote
  class Yahoo
    URL = "http://ichart.finance.yahoo.com/table.csv".freeze
    PARAMS = "s=%s&a=%02d&b=%d&c=%d&d=%02d&e=%d&f=%d&g=d&ignore=.csv".freeze

    def self.fetch(symbol, date)
      resp = Net::HTTP.get_response(uri(symbol, date - 7, date))     
      if resp.code.to_i == 200
        resp.body
      else
        raise Error.new("Failure retrieving quote for #{symbol} on " +
                        "#{date.to_s}: #{resp.message} (#{resp.code})")
      end
    end

    def self.uri(symbol, start_date, end_date)
      params = [ symbol.to_s,
                 start_date.month-1, start_date.day, start_date.year,
                 end_date.month-1, end_date.day, end_date.year ]
      param_str = PARAMS % params

      URI("#{URL}?#{param_str}")
    end
    private_class_method :uri
  end
end
