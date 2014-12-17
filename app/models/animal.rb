class Animal < ActiveRecord::Base
	#Relationships
	belongs_to :genus, :class_name => 'Gen', :foreign_key => 'gen_id'
	
	#Validations
	SPC_REGEX = /\A[a-z.]+\Z/ #Only lowercase letters and periods
	COM_REGEX = /\A[A-Za-z\s]+\Z/ #Letters and spaces
	CD_REGEX = /\A[A-Z]{3}\s{1}(?:[A-Z]{4}|[A-Z]{3}[.]{1})\Z/
	# 3 Caps + space + (4 Caps Or 3 Caps and a period)

	validates :species_name, :presence => true,
	  :format => {:with => SPC_REGEX,
	  :message => 'must contain only lowercase letters'}

	validates :common_name, 
	  :allow_blank => true,
	  :format => {:with => COM_REGEX, 
	  :message => 'must contain only letters and spaces'}

	validates :species_cd, :presence => true,
	  :format => {:with => CD_REGEX, 
	  :message => 'must be capitalized, with first 4 letters
	  of the genus and first 3 of the species'},
	  :uniqueness => true

	validates :species_nr, :presence => true,
	  :numericality => {:only_integer => true},
	  :uniqueness => true

	validates :gen_id, :presence => true,
	  :numericality => {:only_integer => true}

end
