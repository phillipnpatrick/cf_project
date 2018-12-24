class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :products, :dexription, :description
  end
end
