json.array!(@events) do |event|
    json.extract! event, :id
    json.start event.start_time
    json.end event.end_time
    json.description ""
    json.title event.name
    json.color event.color unless event.color.blank?
    json.id event.id
    json.edit_url edit_course_event_path(@course,event)
    json.update_url course_event_path(@course,event)
    json.destroy_url course_event_destroy_path(@course,event)
  end