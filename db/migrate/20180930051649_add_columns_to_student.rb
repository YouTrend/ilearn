class AddColumnsToStudent < ActiveRecord::Migration[5.1]
  def change
    add_column :students, :identity_code, :string
    add_column :students, :address, :string
    add_column :students, :remark, :string
  end
end
