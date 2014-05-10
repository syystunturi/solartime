require_relative '../maidenhead'

include Maidenhead

describe Maidenhead do

  describe ".locator_to_coordinates" do
    it "calculates the coordinates of Helsinki correctly" do
      longitude, latitude = locator_to_coordinates( "KP20LE" )
      longitude.should eq(24.958333333333336)
      latitude.should eq(60.1875)
    end
  end

end
