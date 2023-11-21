require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do 

    # Valid user with all required attributes
    it 'is valid with valid attributions & saves' do
      user = User.new(
        email: 'text@example.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'John',
        last_name: 'Doe'
      )
      # checks if user object is 'valid'
      expect(user).to be_valid
      # with the user object valid, it is successfully saved to the db
      expect(user.save).to be_truthy
    end

    # Invalid without a first_name
    it 'is not valid without a first name' do
      user = User.new(
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    # Invalid without a last_name
    it 'is not valid without a last name' do
      user = User.new(
        first_name: 'John',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    # Invalid without an email
    it 'is not valid without a email' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    # Invalid with a duplicate email (case-sensitive)
    it 'it is not valid with a duplicate email (case-sensitive)' do
      User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      user = User.new(
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'TEST@example.com',
        password: 'different_password',
        password_confirmation: 'different_password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    # Invalid without a password
    it 'is not valid without a password' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password_confirmation: 'password',
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    # Invalid if password & password_confirmation do not match
    it 'is not valid when the confirmation password does not match the password' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'different_password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    # Invalid if password is not at minimum length when account is created
    it 'is not valid when the password is not the minimum in length required' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'pass',
        password_confirmation: 'pass'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    
    # User should be returned if authentication is successful
    it 'returns the user if authentication is successful' do
      user = User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      # Authenticate with correct credentials
      authenticated_user = User.authenticate_with_credentials('test@example.com', 'password')
      # Authenticated user is the created user
      expect(authenticated_user).to eq(user)
    end

    # Authentication should return nil if email is not found
    it 'returns nil if email is not found' do 
      authenticated_user = User.authenticate_with_credentials('nonexistent@example.com', 'password')
      expect(authenticated_user).to be_nil
    end

    # Authetication should return nil if the password is incorrect
    it 'returns nil if authentication fails' do
      user = User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )

      authenticated_user = User.authenticate_with_credentials('test@example.com', 'wrong_password')
      expect(authenticated_user).to be_nil
    end

    # Authentication should be case-insensitive for email
    it 'is case-insensitive for email' do
      user = User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('TEST@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    # Authentication should ignore leading and trailing whitespaces in email
    it 'ignores leading and trailing whitespaces in email' do
      user = User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      authenticated_user = User.authenticate_with_credentials('  test@example.com  ', 'password')
      expect(authenticated_user).to eq(user)
    end
  end

end
