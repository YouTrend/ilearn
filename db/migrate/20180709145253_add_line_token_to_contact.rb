class AddLineTokenToContact < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :line_token, :string

  end
end
