class CreateGroupMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :group_members do |t|
      t.references :group, foreign_key: { to_table: 'groups' }
      t.references :member, foreign_key: { to_table: 'members' }

      t.timestamps
    end
  end
end
