# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPolicy, type: :policy do
  subject { described_class }
  let(:post) { create(:post) }

  context 'everyone' do
    permissions :index?, :show? do
      it 'allows access for everyone' do
        expect(subject).to permit(User.new, post)
        expect(subject).to permit(nil, post)
      end
    end

    permissions :new?, :create? do
      it 'denies access to regular users and guests' do
        expect(subject).not_to permit(User.new, nil)
        expect(subject).not_to permit(nil, nil)
      end
    end

    permissions :edit?, :update?, :destroy? do
      it 'denies access to regular users and guests' do
        expect(subject).not_to permit(User.new, post)
        expect(subject).not_to permit(nil, post)
      end
    end
  end

  context 'authors' do
    let(:author) { create(:user, :author) }

    permissions :new?, :create? do
      it 'denies access to regular users and guests' do
        expect(subject).to permit(author, nil)
      end
    end

    permissions :edit?, :update?, :destroy? do
      it 'allows access if the user is the author of the post' do
        expect(subject).to permit(author, create(:post, author: author))
      end

      it 'denies access if the user is not the author of the post' do
        expect(subject).not_to permit(author, post)
      end
    end
  end

  context 'admins' do
    permissions :index?, :show?, :new?, :create?, :edit?, :update?, :destroy? do
      it 'allows access to everything' do
        expect(subject).to permit(create(:user, :admin), post)
      end
    end
  end
end
