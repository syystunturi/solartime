# encoding: utf-8
require_relative 'maidenhead'
require 'date'
# The functions needed for calculating sunrise and sunset times.
class Solartime
  include Maidenhead

  SUN_TOUCHING_HORIZON = -0.833
  CIVIL_TWILIGHT = -6
  RAD_TO_DEG = 180 / Math::PI

  def command_line_solartime(city, location)
    if location.length != 6
      city = 'München'
      location = 'JN58SD'
    elsif !/[A-Ra-r][A-Ra-r][0-9][0-9][A-Xa-x][A-Xa-x]/.match(location)
      city = 'Berlin'
      location = 'JO62QM'
    end

    longitude, latitude = locator_to_coordinates(location)
    location_label = '%s (%s: %.3f %.3f)'
    puts location_label % [city, location, longitude, latitude]
  end

  def web_server_solartime(_city, location)
    locator_to_coordinates(location)
  end

  private

  def day_number
    Date.today.jd - Date.new(2000, 1, 1).jd
  end

  def obliquity_of_the_ecliptic(d = nil)
    d ||= day_number
    23.4393 - 0.0000003563 * d
  end

  def orbital_elements_of_the_sun(d = nil)
    d ||= day_number
    n = 0.0
    i = 0.0
    w = 282.9404 + 0.0000470935 * d
    a = 1.000000
    e = 0.016709 - 0.000000001151 * d
    m = 356.0470 + 0.9856002585 * d
    m = normalize_angle m
    [n, i, w, a, e, m]
  end

  def suns_right_ascension(ye, xe)
    Math.atan2(ye, xe) * RAD_TO_DEG
  end

  def declination(ze, xe, ye)
    Math.atan2(ze, Math.sqrt(xe**2 + ye**2))
  end

  def calculate_local_hour_angle(h, declination, latitude)
    h /= RAD_TO_DEG
    declination /= RAD_TO_DEG
    latitude /= RAD_TO_DEG

    local_hour_angle = (Math.sin(h) - Math.sin(latitude) *
                        Math.sin(declination)) /
                       (Math.cos(latitude) * Math.cos(declination))

    if local_hour_angle < -1
      local_hour_angle = -1
    elsif local_hour_angle > 1
      local_hour_angle = 1
    end

    Math.acos(local_hour_angle) * RAD_TO_DEG
  end

  def normalize_angle(angle)
    if angle > 360
      while angle > 360 do
        angle -= 360
      end
    elsif angle < 0
      while angle < 0
        angle += 360
      end
    end
    angle
  end
end
