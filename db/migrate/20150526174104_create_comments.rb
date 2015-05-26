class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :image_name
      t.integer :user_id
      t.integer :task_id
      t.timestamps
    end
  end
end
