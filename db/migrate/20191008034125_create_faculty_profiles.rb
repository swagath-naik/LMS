class CreateFacultyProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :faculty_profiles do |t|
      t.string :fname
      t.string :fdes

      t.timestamps
    end
  end
end
