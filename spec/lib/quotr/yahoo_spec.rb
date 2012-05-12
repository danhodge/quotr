require 'spec_helper.rb'

describe Quotr::Yahoo do
  describe ".fetch" do
    let(:symbol) { :abcd  }
    let(:date)   { Time.now }
    let(:body)   { "<CSV DATA>" }
    let(:mock_resp) { mock(:code => 200, :body => body) }

    before { Net::HTTP.should_receive(:get_response).and_return(mock_resp) }
    
    subject { Quotr::Yahoo }

    it { subject.fetch(symbol, date).should == body }
  end
end
