class RemoveLineAuthorizeUrlToContact < ActiveRecord::Migration[5.1]
  def change
    remove_column :contacts, :line_authorize_url
  end
end
