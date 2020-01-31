# frozen_string_literal: true

namespace :sample_data do
  desc 'Loads sample data into the database for testing'
  task load: :environment do
    raise 'Production environment detected!' if Rails.env.production?

    # Create the admin user
    user = User.find_by(email: 'admin@localhost')
    if user.blank?
      user = User.create!(
        email: 'admin@localhost',
        password: 'test1234'
      )
      user.add_role(:admin)
    end

    # Create posts
    next unless Post.all.empty?

    # Anonymous posts
    10.times do
      if rand > 0.3
        FactoryBot.create(:post, :with_tag, author: user)
      else
        FactoryBot.create(:post, :with_tag, :anonymous)
      end
    end
  end
end
