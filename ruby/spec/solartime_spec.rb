require 'active_support/core_ext/kernel/reporting'
require_relative '../solartime'

describe Solartime do

  before(:all) do
    @solartime = Solartime.new
  end

  describe ".command_line_solartime" do
    it "calculates the coordinates of Berlin correctly" do
      output = capture :stdout do
        @solartime.command_line_solartime "Berlin", "JO62QM"
      end
      expect(output).to include 'Berlin (JO62QM: 13.375 52.521)'
    end
  end

  describe ".web_server_solartime" do
    it "calculates the coordinates of Munich correctly" do
      a, b = @solartime.web_server_solartime "München", "JN58SD"
      a.should eq(11.541666666666666)
      b.should eq(48.145833333333336)
    end
  end

end
