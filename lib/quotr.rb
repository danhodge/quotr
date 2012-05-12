require "quotr/yahoo"
require "quotr/yahoo_parser"

module Quotr
  class Error < StandardError; end

  def self.close(symbol, date=Date.today)
    results = YahooParser.parse(Yahoo.fetch(symbol, date))
    results[date.to_date] || results.values.first
  end
end
