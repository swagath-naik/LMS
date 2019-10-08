class CreateAdminProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_profiles do |t|
      t.string :key

      t.timestamps
    end
  end
end
