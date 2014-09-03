class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :city
      t.string :title
      t.text :body_page
      t.text :body
      t.integer :search_id
      t.integer :city_id
      t.integer :user_id

      t.timestamps
    end
  end
end
