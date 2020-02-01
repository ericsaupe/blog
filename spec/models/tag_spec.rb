# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'is valid with valid attributes' do
    expect(Tag.new(name: 'test')).to be_valid
  end

  it 'is expected to clean the name' do
    tag = Tag.create(name: '  test  ')
    expect(tag.name).to eq('test')
  end

  it 'is expected to validate uniqueness via clean and not be case sensitive' do
    tag = create(:tag)
    # Exact name not unique
    expect(Tag.new(name: tag.name)).not_to be_valid
    # Cleaned name not unique
    expect(Tag.new(name: "  #{tag.name}  ")).not_to be_valid
    # Case insensitive name not unique
    expect(Tag.new(name: tag.name.upcase)).not_to be_valid
  end
end
