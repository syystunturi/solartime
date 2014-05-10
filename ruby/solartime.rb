# encoding: utf-8
require_relative 'maidenhead'
require 'date'

class Solartime

  include Maidenhead

  SUN_TOUCHING_HORIZON = -0.833
  CIVIL_TWILIGHT = -6
  RAD_TO_DEG = 180 / Math::PI

  def command_line_solartime city, location
    if location.length != 6
      city, location = "München", "JN58SD"
    elsif !/[A-Ra-r][A-Ra-r][0-9][0-9][A-Xa-x][A-Xa-x]/.match(location)
      city, location = "Berlin", "JO62QM"
    end

    longitude, latitude = locator_to_coordinates( location )
    location_label = "%s (%s: %.3f %.3f)"
    puts location_label % [city, location, longitude, latitude]
  end

  def web_server_solartime city, location
    locator_to_coordinates( location )
  end

  private

  def day_number
    Date.today.jd - Date.new(2000, 1, 1).jd
  end

  def suns_right_ascension ye, xe
    Math.atan2(ye, xe) * RAD_TO_DEG
  end

  def declination ze, xe, ye
    Math.atan2( ze, Math.sqrt(xe**2 + ye**2) )
  end

  def calculate_local_hour_angle h, declination, latitude
    h = h / RAD_TO_DEG
    declination = declination / RAD_TO_DEG
    latitude = latitude / RAD_TO_DEG

    local_hour_angle = (Math.sin(h) - Math.sin(latitude) * Math.sin(declination)) /
                          (Math.cos(latitude) * Math.cos(declination))

    if local_hour_angle < -1
      local_hour_angle = -1
    elsif local_hour_angle > 1
      local_hour_angle = 1
    end

    Math.acos(local_hour_angle) * RAD_TO_DEG
  end

end