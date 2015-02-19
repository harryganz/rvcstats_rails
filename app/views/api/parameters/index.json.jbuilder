json.array! @parameters do |p|
  json.SPECIES_CD p.species.species_cd
  json.LC p.length_at_capture.present? ? p.length_at_capture : "NA"
  json.LM p.length_at_maturity.present? ? p.length_at_maturity : "NA"
  json.WLEN_A p.wlen_a.present? ? p.wlen_a.to_f : "NA"
  json.WLEN_B p.wlen_b.present? ? p.wlen_b.to_f : "NA"
end
