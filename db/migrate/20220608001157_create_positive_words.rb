class CreatePositiveWords < ActiveRecord::Migration[6.0]
  def change
    create_table :positive_words do |t|
      t.string :speaker, null: false
      t.text :word, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
