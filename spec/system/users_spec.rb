# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'authentication' do
    describe 'registration' do
      it 'registers successfully' do
        visit('/')
        click_on('Sign up')
        fill_in('Email', with: Faker::Internet.email)
        fill_in('Password', with: 'test1234')
        fill_in('Password confirmation', with: 'test1234')
        within('form') do
          click_on('Sign up')
        end
        expect(page).to have_text('Welcome! You have signed up successfully.')
        expect(page).to have_css('.notification.is-success')
      end

      it 'requires all fields' do
        email = Faker::Internet.email

        visit('/')
        click_on('Sign up')
        within('form') do
          click_on('Sign up')
        end
        expect(page).not_to have_text('Welcome! You have signed up successfully.')
        expect(page).to have_text("Email can't be blank")

        fill_in('Email', with: email)
        within('form') do
          click_on('Sign up')
        end
        expect(page).not_to have_text('Welcome! You have signed up successfully.')
        expect(page).not_to have_text("Email can't be blank")
        expect(page).to have_text("Password can't be blank")

        fill_in('Password', with: 'test1234')
        within('form') do
          click_on('Sign up')
        end
        expect(page).not_to have_text('Welcome! You have signed up successfully.')
        expect(page).not_to have_text("Email can't be blank")
        expect(page).not_to have_text("Password can't be blank")
        expect(page).to have_text("Password confirmation doesn't match Password")

        fill_in('Password', with: 'test1234')
        fill_in('Password confirmation', with: 'test1234')
        within('form') do
          click_on('Sign up')
        end
        expect(page).to have_text('Welcome! You have signed up successfully.')
        expect(page).to have_css('.notification.is-success')
      end
    end
  end
end
