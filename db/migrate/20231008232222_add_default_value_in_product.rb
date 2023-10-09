class AddDefaultValueInProduct < ActiveRecord::Migration[5.1]
  def change
    change_column :produtos, :quantidade, :integer, :default => 0
  end
end
