require 'spec_helper.rb'

describe Quotr do
  let(:symbol) { :abcd }
  let(:result) { { Date.new(2012, 4, 27) => BigDecimal('5.12'),
                   Date.new(2012, 4, 26) => BigDecimal('4.95'),
                   Date.new(2012, 4, 25) => BigDecimal('5.64')  } }
  before do
    Quotr::Yahoo.should_receive(:fetch).and_return("<CSV>")
    Quotr::YahooParser.should_receive(:parse).and_return(result)
  end

  describe '.close' do
    subject { Quotr.close(symbol, date) }  

    context 'on a trade date' do
      let(:date) { Date.new(2012, 4, 25) }

      it 'gets the close on that date' do
        should == result[date]
      end
    end

    context 'on a non-trade date' do
      let(:date) { Date.new(2012, 4, 28) }

      it 'gets the most recent close' do
        should == result[Date.new(2012, 4, 27)]    
      end
    end
  end
end
