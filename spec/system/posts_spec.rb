# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'new' do
    it 'renders the new post form' do
      visit '/posts/new'
      expect(page).to have_text('New Post')
      expect(page).to have_field('Title')
      expect(page).to have_css('input#post_title[required]')
      expect(page).to have_css('trix-editor[required]')
      expect(page).to have_button('Submit')
      expect(page).to have_button('Cancel')
    end

    it 'creates the post successfully' do
      visit '/posts/new'
      fill_in('Title', with: 'Test Title')
      find('trix-editor').click.set('Test text')
      click_on('Submit')
      expect(page).to have_text('Created the post successfully!')
      expect(page).to have_text('Test Title')
      expect(page).to have_text('Test text')
      expect(page).not_to have_button('Submit')
      expect(page).not_to have_button('Cancel')
    end
  end
end
