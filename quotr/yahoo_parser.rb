require 'bigdecimal'
require 'csv'

module Quote
  class YahooParser
    def self.parse(data)
      result = {}
      CSV.parse(data, :headers => true) do |row|
        date = Date.strptime(row['Date'], '%Y-%m-%d')
        result[date] = BigDecimal(row['Close'])
      end

      # return results sorted by date descending
      Hash[result.sort.reverse]
    end
  end
end
