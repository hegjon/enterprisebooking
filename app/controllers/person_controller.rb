class PersonController < ApplicationController
  def list
    people = Person.all
    ok people
  end
  
  def show
    person = Person.find(params[:id])
    ok person
  end

  def create
    person = Person.new(params[:person])
    person.save!
    created person
  end
  
  def update
    person = Person.find(params[:id])
    person.update_attributes!(params[:person])
    updated person
  end

  def destroy
    person = Person.find(params[:id])
    person.destroy
    destroyed
  end
end
