require 'rails_helper'

RSpec.describe User, type: :model do
  
  descrbe 'Validations' do 

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
    it 'is not valid without a first_name' do
      user = User.new(
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("First name cannont be blank")
    end

    # Invalid without a last_name
    it 'is not valid without a last_name' do
      user = User.new(
        first_name: 'John',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Last name cannot be blank")
    end

    # Invalid without an email
    it 'is not valid without a email'
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email cannot be blank")
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
      expects(user).to_not be_valid
      expects(user.errors.full_messages).to include("Email is already in use with another account")
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
      expect(user.errors.full_messages).to include("Password cannot be blanke")
    end

    # Invalid if password & password_confirmation do not match
    it 'is not valid when the confirmation_password does not match the password' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'different_password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("The input passwords must match")
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
      expect(user.errors.full_messages).to include("Password must be at least #{User.password_length} characters long")
    end
  end
end
