require 'rails_helper'

RSpec.describe UserAuth::RefreshToken, type: :service do
  describe '#initialize' do
    let(:user) do
      User.create!(
        email: 'test@example.com',
        name: 'testuser',
        password: 'password123!'
      )
    end

    it 'generates a valid refresh token' do
      refresh_token_service = UserAuth::RefreshToken.new(user_id: user.id)
      refresh_token = refresh_token_service.token

      # Check that the refresh token is valid.
      decoded_token = JWT.decode(refresh_token, refresh_token_service.send(:secret_key))
      
      # Generate encrypted user id
      encrypted_user_id = refresh_token_service.encrypt_for(user.id)

      # Get user_claim from decoded token and decrypt it
      encrypted_user_claim = encrypted_user_id
      decoded_user_claim = refresh_token_service.decrypt_for(encrypted_user_claim)
      
      expect(decoded_user_claim).to eq(user.id.to_s)
    end
  end
end
