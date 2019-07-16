# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  describe 'index' do
    let!(:posts) { create_list(:post, 3) }

    it 'renders a list of posts' do
      visit '/'
      posts.each do |post|
        expect(page).to have_link(post.title)
        expect(page).to have_text(post.content)
      end
    end
  end

  describe 'new' do
    it 'renders the new post form' do
      visit '/'
      click_on('New Post')
      expect(page).to have_selector('h1', text: 'New Post')
      expect(page).to have_field('Title')
      expect(page).to have_css('input#post_title[required]')
      expect(page).to have_css('trix-editor[required]')
      expect(page).to have_button('Submit')
      expect(page).to have_button('Cancel')
    end
  end

  describe 'create' do
    it 'creates the post successfully' do
      title = Faker::Lorem.sentence
      body = Faker::Lorem.paragraph

      visit '/'
      click_on('New Post')
      fill_in('Title', with: title)
      find('trix-editor').click.set(body)
      click_on('Submit')
      expect(page).to have_text('Created the post successfully!')
      expect(page).to have_text(title)
      expect(page).to have_text(body)
      expect(page).not_to have_button('Submit')
      expect(page).not_to have_button('Cancel')
    end
  end
end
