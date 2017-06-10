class AddUserIdToPageants < ActiveRecord::Migration[5.1]
  def change
    add_column :pageants, :user_id, :integer
  end
end
