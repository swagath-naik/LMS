class CreateBookIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :book_issues do |t|
      t.integer :BookId
      t.string :username

      t.timestamps
    end
  end
end
