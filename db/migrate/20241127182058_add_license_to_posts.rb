class AddLicenseToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :license, :string
  end
end