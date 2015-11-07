require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context "valid customer" do
    it "should have a valid name" do
      expect(user.first_name).to be_present
      expect(user.last_name).to be_present
    end

    it 'should be a customer account' do
      expect(user.role).to be == User::CUSTOMER
    end
  end

  context 'with invalid data' do
    let(:user) { build(:user, first_name: nil, last_name: nil) }

    before { user.save }

    it 'should not be valid' do
      expect(user).not_to be_valid
    end
  end
end
