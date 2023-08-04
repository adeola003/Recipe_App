require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { User.create(name: 'anything', email: 'anything@email.com', password: 'password') }

    it 'checking validations' do
      expect(user).to be_valid
    end

    it 'The password must be at least 6 characters long to be considered valid' do
      user.password = 'short'
      expect(user).to_not be_valid
    end
    
    it 'invalid without email' do
        user.email = nil
        expect(user).to_not be_valid
      end
  
  end

  describe 'associations' do
    
    it 'It should have multiple recipes associated with it' do
        expect(User.reflect_on_association(:recipes).macro).to eq(:has_many)
      end
    it 'It should have multiple foods associated with it' do
      expect(User.reflect_on_association(:foods).macro).to eq(:has_many)
    end
  end
end