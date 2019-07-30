class AddAuthorToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :author_id, :integer, index: true
  end
end
