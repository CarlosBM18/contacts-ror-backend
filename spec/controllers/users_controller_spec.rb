require 'rails_helper'

RSpec.describe User, :type => :model do

  user = User.new(email: 'carlos@test.es', password: 'test123')
  
  it "is valid with valid attributes" do
    expect(user).to be_valid
  end

  it "is incorrect without email" do
    user.email = nil
    expect(user).to_not be_valid
  end

  it "is incorrect without password" do
    user.password = nil
    expect(user).to_not be_valid
  end

end