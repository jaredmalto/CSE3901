class RemoveUserIdFromPresentation < ActiveRecord::Migration[7.0]
  def change
    remove_column :presentations, :user_id, :integer
  end
end
