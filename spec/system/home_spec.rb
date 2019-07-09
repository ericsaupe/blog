# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :system do
  it 'displays hello, world' do
    visit '/'
    expect(page).to have_text('Hello, World!')
  end
end
