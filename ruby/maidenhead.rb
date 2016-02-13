# encoding: utf-8
# Calculates the coordinates from a locator
module Maidenhead
  def locator_to_coordinates(locator)
    qth = locator.upcase.each_byte.to_a

    longitude = 20 * (qth[0] - 65) - 180 +
                2 * (qth[2] - 48) +
                5.0 * (qth[4] - 65) / 60 +
                2.5 / 60

    latitude = 10 * (qth[1] - 65) - 90 +
               qth[3] - 48 +
               2.5 * (qth[5] - 65) / 60 +
               1.25 / 60

    [longitude, latitude]
  end
end
