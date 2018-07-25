class AddTrendsetidToTrends < ActiveRecord::Migration[5.2]
  def change
    add_column :trends, :trendset_id, :integer
  end
end
