class CreatePostTags < ActiveRecord::Migration[6.0]
  def change
    create_table :post_tags do |t|
      t.references :post, foreign_key: true
      t.references :tag, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :post_tags, %i[post_id tag_id], unique: true
  end
end
