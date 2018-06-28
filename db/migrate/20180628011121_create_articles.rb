class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :name
      t.string :url
      t.text :description
      t.text :readme
      t.integer :ranking
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
