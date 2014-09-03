class CreateEmailers < ActiveRecord::Migration
  def change
    create_table :emailers do |t|
      t.string :email
      t.string :subject
      t.string :body
      t.integer :user_id

      t.timestamps
    end
  end
end
