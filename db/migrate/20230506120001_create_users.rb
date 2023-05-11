class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.text :description
      t.string :email
      t.date :date_of_birth
      t.string :gender
      t.references :city, index: true
      t.string :password_digest

      t.timestamps
    end
  end
end
