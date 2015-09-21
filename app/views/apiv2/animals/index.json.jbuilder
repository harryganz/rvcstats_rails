json.array! @species do |s|
  json.id s.id
  json.species_cd s.species_cd
  json.sciname s.sciname
  json.comname s.comname
  json.length_at_capture s.parameter.nil? ? nil : s.parameter.length_at_capture
  json.length_at_maturity s.parameter.nil? ? nil: s.parameter.length_at_maturity
  json.wlen_a s.parameter.nil? ? nil: s.parameter.wlen_a
  json.wlen_b s.parameter.nil? ? nil : s.parameter.wlen_b
end
