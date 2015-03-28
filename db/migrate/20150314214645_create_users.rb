class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t| # |t| = table
      t.string :first_name 
      t.string :last_name
      t.string :email
      t.string :gender
      t.date :birthdate
    end
  end
end
