require 'test_helper'

class PersonCategoryTest < ActiveSupport::TestCase
  fixtures :rooms, :people
  
  def test_auto_on
    auto_on = PersonCategory.new(:name => "auto_on", :abbrivation => "ON", :order => 1, :auto_on => 10)  
    auto_on.save!
    
    b = Booking.new
    b.arrival = Time.now
    b.departure = Time.now + 60*60*24
    b.room = @singleroom1
    b.person = @jonny
    b.status = 10
    b.save!
    
    assert(@jonny.person_categories.include?(auto_on))
  end
  
  def test_auto_off
    auto_off = PersonCategory.new(:name => "auto_off", :abbrivation => "OFF", :order => 2, :auto_off => 10)  
    auto_off.save!
    @jonny.person_categories << auto_off
    
    b = Booking.new
    b.arrival = Time.now
    b.departure = Time.now + 60*60*24
    b.room = @singleroom1
    b.person = @jonny
    b.status = 10
    b.save!

    assert (!@jonny.person_categories.include?(auto_off))
  end
end