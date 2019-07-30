# frozen_string_literal: true

namespace :sample_data do
  desc 'Loads sample data into the database for testing'
  task load: :environment do
    raise 'Production environment detected!' if Rails.env.production?

    # Create the admin user
    user = User.find_by(email: 'admin@localhost')
    if user.blank?
      User.create!(
        email: 'admin@localhost',
        password: 'test1234'
      )
    end

    # Create posts
    next unless Post.all.empty?

    # Anonymous posts
    FactoryBot.create(:action_text,
                      record: FactoryBot.create(:post, :anonymous))
    # User posts
    FactoryBot.create(:action_text,
                      record: FactoryBot.create(:post, author: user))
  end
end
