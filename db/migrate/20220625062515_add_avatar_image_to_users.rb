class AddAvatarImageToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :avatar_image, :string
  end
end
