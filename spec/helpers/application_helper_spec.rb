# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#bulma_flash_class' do
    it 'returns :danger when :error is given' do
      expect(helper.bulma_flash_class(:error)).to eq(:danger)
    end

    it 'returns the key when nothing special is happening' do
      non_special_keys = [
        :success,
        :warning,
        :timeout,
        :special,
        :anything
      ]
      non_special_keys.each do |key|
        expect(helper.bulma_flash_class(key)).to eq(key)
      end
    end
  end
end
