class CreateGithubInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :github_infos do |t|
      t.string :title
      t.string :description
      t.string :url
      t.string :account
      t.text :readme, :limit => 4294967295
      t.integer :star_count
      t.integer :fork_count
      t.timestamps
    end
  end
end
