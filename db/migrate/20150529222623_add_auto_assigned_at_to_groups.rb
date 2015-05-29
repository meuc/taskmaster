class AddAutoAssignedAtToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :auto_assigned_at, :datetime
  end
end
