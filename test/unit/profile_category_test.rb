require 'test_helper'

class ProfileCategoryTest < ActiveSupport::TestCase
  fixtures :rooms, :profiles
  
  def test_auto_on
    auto_on = ProfileCategory.new(:name => "auto_on", :abbrivation => "ON", :order => 1, :auto_on => 10)  
    auto_on.save!
    
    b = Booking.new
    b.arrival = Time.now
    b.departure = Time.now + 60*60*24
    b.profile = @jonny
    b.status = 10
    b.periodes << Periode.new do |p|
      p.room = @singleroom1
      p.from = b.arrival
      p.to   = b.departure
    end    
    b.save!
    
    assert(@jonny.profile_categories.include?(auto_on))
  end
  
  def test_auto_off
    auto_off = ProfileCategory.new(:name => "auto_off", :abbrivation => "OFF", :order => 2, :auto_off => 10)  
    auto_off.save!
    @jonny.profile_categories << auto_off
    
    b = Booking.new
    b.arrival = Time.now
    b.departure = Time.now + 60*60*24
    b.profile = @jonny
    b.status = 10
    b.periodes << Periode.new do |p|
      p.room = @singleroom1
      p.from = b.arrival
      p.to   = b.departure
    end    
    b.save!

    assert(!@jonny.profile_categories.include?(auto_off))
  end
end
