require 'rails_helper'

RSpec.describe Contact, :type => :model do

  user = User.create(email: 'carlos@test.es', password: 'test123')

  contact = Contact.create(first_name: 'Marcel', last_name: 'Dalmau', phone_number: 666777888, email: 'marcel@test.es', user_id: user.id)

  it "is valid with valid attributes" do
    expect(contact).to be_valid
  end

  it "is incorrect without first_name" do
    contact.first_name = nil
    expect(contact).to_not be_valid
  end  
  
  it "is incorrect without last_name" do
    contact.last_name = nil
    expect(contact).to_not be_valid
  end

  it "is incorrect without phone_number" do
    contact.phone_number = nil
    expect(contact).to_not be_valid
  end

  it "is incorrect without email" do
    contact.email = nil
    expect(contact).to_not be_valid
  end

  user.destroy
end