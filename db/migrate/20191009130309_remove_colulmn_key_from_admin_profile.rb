class RemoveColulmnKeyFromAdminProfile < ActiveRecord::Migration[6.0]
  def change

    remove_column :admin_profiles, :key, :string
  end
end
