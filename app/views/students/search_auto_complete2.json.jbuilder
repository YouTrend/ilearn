json.array! @students do |student|
  json.value student.id
  json.label student.name
  json.grade student.grade
end