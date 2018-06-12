class RemoveEventIdFromAttendances < ActiveRecord::Migration[5.1]
  def change
  	remove_column :attendances, :event_id
  end
end
