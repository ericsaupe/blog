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

  describe 'show' do
    let!(:post) { create(:post) }

    it 'renders the post' do
      visit '/'
      click_on(post.title)
      expect(page).to have_selector('h1', text: post.title)
    end
  end

  context 'authenticated' do
    describe 'user' do
      let(:user) { create(:user) }

      before(:each) do
        login_as(user, scope: :user)
      end

      describe 'new' do
        it 'does not render the new post form' do
          visit '/'
          expect(page).not_to have_link('New Post')

          visit '/posts/new'
          expect(page).not_to have_selector('h1', text: 'New Post')
          expect(page).not_to have_field('Title')
          expect(page).not_to have_css('input#post_title[required]')
          expect(page).not_to have_css('trix-editor[required]')
          expect(page).not_to have_button('Submit')
          expect(page).not_to have_button('Cancel')
        end
      end

      context 'existing post' do
        let!(:post) { create(:post) }

        describe 'edit' do
          it 'does not render the edit form when Edit is clicked' do
            visit '/'
            expect(page).not_to have_link('Edit')

            visit "/posts/#{post.id}/edit"
            expect(page).not_to have_text('Edit Post')
            expect(page).not_to have_selector('h1', text: post.title)
          end
        end

        describe 'destroy' do
          it 'deletes the post with a confirmation message' do
            visit '/'
            expect(page).not_to have_link('Delete')
          end
        end
      end
    end

    describe 'author' do
      let(:user) { create(:user, :author) }

      before(:each) do
        login_as(user, scope: :user)
      end

      describe 'new' do
        it 'renders the new post form' do
          visit '/'
          click_on('New Post')
          expect(page).to have_selector('h1', text: 'New Post')
          expect(page).to have_field('Title')
          expect(page).to have_field('Tags')
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
          find('.tagsinput input').click.set('test-tag')
          find('.tagsinput input').native.send_keys(:return)
          find('trix-editor').click.set(body)
          click_on('Submit')
          expect(page).to have_text('Created the post successfully!')
          expect(page).to have_text(title)
          expect(page).to have_text('test-tag')
          expect(page).to have_text(body)
          expect(page).to have_text("By #{user.email}")
          expect(page).not_to have_button('Submit')
          expect(page).not_to have_button('Cancel')
        end
      end

      context 'existing post' do
        context 'own post' do
          let!(:post) { create(:post, :with_tag, author: user) }
          let(:tag) { post.tags.first }

          describe 'edit' do
            it 'renders the edit form when Edit is clicked' do
              visit '/'
              within("#post-#{post.id}") do
                click_on('Edit')
              end
              expect(page).to have_text('Edit Post')
              expect(page).to have_text(post.title)
              expect(page).to have_text(tag.name)
            end
          end

          describe 'update' do
            it 'updates the post when the edit form is submitted' do
              new_title = 'Updated title'
              new_body = 'Updated body'
              visit '/'
              within("#post-#{post.id}") do
                click_on('Edit')
              end
              fill_in('Title', with: new_title)
              find('.tagsinput input').click.set('test-tag')
              find('.tagsinput input').native.send_keys(:return)
              find(".tagsinput [data-tag='#{tag.name}'] a.is-delete").click
              find('.tagsinput input').click.set('another-tag')
              find('.tagsinput input').native.send_keys(:return)
              find('trix-editor').click.set(new_body)
              click_on('Submit')
              expect(page).to have_text('Updated the post successfully!')
              expect(page).to have_text(new_title)
              expect(page).to have_text('test-tag')
              expect(page).to have_text('another-tag')
              expect(page).not_to have_text(tag.name)
              expect(page).to have_text(new_body)
              expect(page).not_to have_button('Submit')
              expect(page).not_to have_button('Cancel')
            end
          end

          describe 'destroy' do
            it 'deletes the post with a confirmation message' do
              visit '/'
              within("#post-#{post.id}") do
                click_on('Edit')
              end
              page.accept_confirm do
                click_on('Delete')
              end
              expect(page).to have_text('Deleted the post successfully!')
              expect(page).not_to have_text(post.title)
            end
          end
        end

        context 'others posts' do
          let!(:post) { create(:post) }

          describe 'edit' do
            it 'does not render the edit form when Edit is clicked' do
              visit '/'
              expect(page).not_to have_link('Edit')

              visit "/posts/#{post.id}/edit"
              expect(page).not_to have_text('Edit Post')
              expect(page).not_to have_selector('h1', text: post.title)
            end
          end

          describe 'destroy' do
            it 'deletes the post with a confirmation message' do
              visit '/'
              expect(page).not_to have_link('Delete')
            end
          end
        end
      end
    end

    describe 'admin' do
      let(:user) { create(:user, :admin) }
      let!(:post) { create(:post) }

      before(:each) do
        login_as(user, scope: :user)
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
          expect(page).to have_text("By #{user.email}")
          expect(page).not_to have_button('Submit')
          expect(page).not_to have_button('Cancel')
        end
      end

      describe 'edit' do
        it 'renders the edit form when Edit is clicked' do
          visit '/'
          within("#post-#{post.id}") do
            click_on('Edit')
          end
          expect(page).to have_text('Edit Post')
          expect(page).to have_text(post.title)
        end
      end

      describe 'update' do
        it 'updates the post when the edit form is submitted' do
          new_title = 'Updated title'
          new_body = 'Updated body'
          visit '/'
          within("#post-#{post.id}") do
            click_on('Edit')
          end
          fill_in('Title', with: new_title)
          find('trix-editor').click.set(new_body)
          click_on('Submit')
          expect(page).to have_text('Updated the post successfully!')
          expect(page).to have_text(new_title)
          expect(page).to have_text(new_body)
          expect(page).not_to have_button('Submit')
          expect(page).not_to have_button('Cancel')
        end
      end

      describe 'destroy' do
        it 'deletes the post with a confirmation message' do
          visit '/'
          within("#post-#{post.id}") do
            click_on('Edit')
          end
          page.accept_confirm do
            click_on('Delete')
          end
          expect(page).to have_text('Deleted the post successfully!')
          expect(page).not_to have_text(post.title)
        end
      end
    end
  end
end
