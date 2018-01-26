require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation_tests' do

    it "is not valid without a name" do
      user = User.new(:email => "testuser@user.com", :password => "123456").save
      expect(user).to eq(false)
    end

    it "is not valid without an email" do
      user = User.new(:name => "testuser", :password => "123456").save
      expect(user).to eq(false)
    end

    it "is not valid without a password" do
      user = User.new(:name => "testuser", :email => "testuser@user.com").save
      expect(user).to eq(false)
    end

    it "should save successfully" do
      user = User.new(:name => "testuser", :email => "testuser@user.com", :password => "123456").save
      expect(user).to eq(true)
    end

    it { should have_many(:todo) }

    it { should have_many(:item) }

    it { should have_secure_password }
  end
end
