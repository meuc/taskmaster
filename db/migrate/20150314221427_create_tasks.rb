class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :size
      t.string :interval
      t.integer :user_id
      t.integer :group_id
    end
  end
end
