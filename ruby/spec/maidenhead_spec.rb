require_relative '../maidenhead'

include Maidenhead

describe Maidenhead do
  describe '.locator_to_coordinates' do
    it 'calculates the coordinates of Helsinki correctly' do
      longitude, latitude = locator_to_coordinates('KP20LE')
      expect(longitude).to eq(24.958333333333336)
      expect(latitude).to eq(60.1875)
    end
  end
end
