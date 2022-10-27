class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :image
      t.string :image1
      t.string :image2
      t.text :description
      t.string :date
      t.references :user, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
