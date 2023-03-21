class CreateBookComments < ActiveRecord::Migration[6.1]
  def change
    create_table :book_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :post

      t.timestamps
    end
  end
end
