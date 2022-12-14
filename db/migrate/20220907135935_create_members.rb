class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members do |t|
      t.string :name
      t.bigint :phone_number
      t.string :occupation
      t.string :picture
      t.boolean :distance
      t.string :post_held
      t.string :birthday
      t.references :user, foreign_key: { to_table: 'users' }
      t.references :group, foreign_key: { to_table: 'groups' }

      t.timestamps
    end
  end
end
