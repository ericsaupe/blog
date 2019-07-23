# frozen_string_literal: true

namespace :sample_data do
  desc 'Loads sample data into the database for testing'
  task load: :environment do
    # Create the admin user
    user = User.find_by(email: 'admin@localhost')
    if user.blank?
      User.create!(
        email: 'admin@localhost',
        password: 'test1234'
      )
    end
  end
end
