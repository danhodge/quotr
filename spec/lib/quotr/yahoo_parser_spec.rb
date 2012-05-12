require 'spec_helper.rb'

describe Quotr::YahooParser do
  describe ".parse" do
    let(:result) { { Date.new(2012, 4, 4) => BigDecimal("128.12"),
                     Date.new(2012, 4, 3) => BigDecimal("130.99"),
                     Date.new(2012, 4, 2) => BigDecimal("130.76") } }

    subject { Quotr::YahooParser }

    context "given sorted data" do
      let(:data) { "Date,Open,High,Low,Close,Volume,Adj Close\n" +
                   "2012-04-04,128.12,128.12,128.12,128.12,000,128.12\n" +
                   "2012-04-03,130.99,130.99,130.99,130.99,000,130.99\n" + 
                   "2012-04-02,130.76,130.76,130.76,130.76,000,130.76\n" }

      it { subject.parse(data).should == result }
    end

    context "given unsorted data" do
      let(:data) { "Date,Open,High,Low,Close,Volume,Adj Close\n" +
                   "2012-04-02,130.76,130.76,130.76,130.76,000,130.76\n" +
                   "2012-04-04,128.12,128.12,128.12,128.12,000,128.12\n" +
                   "2012-04-03,130.99,130.99,130.99,130.99,000,130.99\n" }

      it { subject.parse(data).should == result }
      it { subject.parse(data).keys.should == result.keys } 
    end
  end
end
