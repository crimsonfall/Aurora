class RenameBodyToDescriptionInPosts < ActiveRecord::Migration[7.2]
  def change
    rename_column :posts, :body, :description
  end
end
