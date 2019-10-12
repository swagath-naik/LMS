class RemoveTotalFromBooks < ActiveRecord::Migration[6.0]
  def change

    remove_column :books, :total, :Integer

    remove_column :books, :left, :boolean
  end
end
