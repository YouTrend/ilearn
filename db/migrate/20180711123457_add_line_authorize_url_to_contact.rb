class AddLineAuthorizeUrlToContact < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :line_authorize_url, :string
  end
end
