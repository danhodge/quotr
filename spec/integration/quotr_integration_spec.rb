require 'spec_helper.rb'
require 'vcr_helper.rb'

describe Quotr do
  describe ".close" do
    let(:sym) { :vfinx }
    let(:invalid_sym) { "NACHOS" }
    let(:date)   { Date.new(2012, 4, 20) }
    let(:future_date) { Date.today + 10 }
    let(:expected_close) { BigDecimal("127.14") }

    subject { Quotr }

    it "retrieves a quote for a valid symbol on a valid day" do
      VCR.use_cassette('all_valid_quote') do
        subject.close(sym, date).should == expected_close
      end
    end

    it "retrieves the quote from the previous day on a holiday" do
      VCR.use_cassette('holiday_quote') do
        subject.close(sym, date + 1).should == expected_close 
      end
    end

    it "fails for a valid symbol on a future day" do
      VCR.use_cassette('future_quote') do
        expect { subject.close(sym, future_date) }.to raise_error(Quotr::Error)
      end
    end

    it "fails for an invalid symbol" do
      VCR.use_cassette('invalid_symbol') do
        expect { subject.close(invalid_sym, date) }.to raise_error(Quotr::Error)
      end
    end

    context 'given a stock symbol' do
      let(:sym) { :f }
      let(:expected_close) { BigDecimal("11.41") }

      it "retrieves a quote for a valid stock symbol" do
        VCR.use_cassette('stock_symbol') do
          subject.close(sym, date).should == expected_close
        end
      end
    end

    context 'given an ETF symbol' do
      let(:sym) { :vti }
      let(:expected_close) { BigDecimal("70.82") }

      it "retrieves a quote for a valid ETF symbol" do
        VCR.use_cassette('etf_symbol') do
          subject.close(sym, date).should == expected_close
        end
      end
    end
  end
end
