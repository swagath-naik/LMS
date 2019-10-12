class AddBookidToBooks < ActiveRecord::Migration[6.0]
   def self.up
  	add_column :books, :bookId, :Integer
  	add_column :books, :issued, :boolean
  end

  def self.down
  	remove_column :books, :total, :Integer
  	remove_column :books, :left, :boolean
  end
end
