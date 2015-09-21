json.array! @samples do |s|
  json.id s.id
  json.time_seen s.time_seen
  json.num s.num
  json.len s.len
  json.animal_id s.animal_id
  json.ssu_id s.animal_id
end
