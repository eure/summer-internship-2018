class CreateTrends < ActiveRecord::Migration[5.2]
  def change
    create_table :trends do |t|
      t.string :name
      t.string :lang
      t.text :description
      t.integer :star_count
      t.string :url

      t.timestamps
    end
  end
end
