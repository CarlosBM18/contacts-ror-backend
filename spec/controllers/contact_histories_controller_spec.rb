require 'rails_helper'

RSpec.describe ContactHistory, :type => :model do

  user = User.create(email: 'carlos@test.es', password: 'test123')
  contact = Contact.create(first_name: 'Marcel', last_name: 'Dalmau', phone_number: 666777888, email: 'marcel@test.es', user_id: user.id)
  contact_history = ContactHistory.create(first_name: 'MarcelD', last_name: 'DalmauD', phone_number: 666777888, email: 'marcel@test.es', user_id: user.id, state: 'updated', contact_id: contact.id)

  it "is valid with valid attributes" do
    expect(contact_history).to be_valid
  end

  it "is incorrect without first_name" do
    contact_history.first_name = nil
    expect(contact_history).to_not be_valid
  end  
  
  it "is incorrect without last_name" do
    contact_history.last_name = nil
    expect(contact_history).to_not be_valid
  end

  it "is incorrect without phone_number" do
    contact_history.phone_number = nil
    expect(contact_history).to_not be_valid
  end

  it "is incorrect without email" do
    contact_history.email = nil
    expect(contact_history).to_not be_valid
  end

  user.destroy
end