class CreateTaggable < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name, null: false, index: true, unique: true

      t.timestamps
    end

    create_table :taggables do |t|
      t.references :tag, index: true
      t.references :taggable, polymorphic: true, index: true
      
      t.timestamps
    end
  end
end
