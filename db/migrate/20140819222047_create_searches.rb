class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :name
      t.string :accepted
      t.string :denied
      t.string :user_id
      t.integer :last_city_id
      t.timestamps
    end
  end
end
