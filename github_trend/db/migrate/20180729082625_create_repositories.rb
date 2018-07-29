class CreateRepositories < ActiveRecord::Migration[5.2]
  def change
    create_table :repositories do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.text :discription
      t.integer :stars

      t.timestamps
    end
    add_index  :repositories, :type
  end
end
