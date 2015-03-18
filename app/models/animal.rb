class Animal < ActiveRecord::Base
	#Relationships
	has_many :samples
	has_one :parameter

	#Validations

	CD_REGEX = /\A[A-Z]{3}\s{1}(?:[A-Z_]{4}|[A-Z]{3}[.]{1})\Z/
	# 3 Caps + space + (4 Caps Or 3 Caps and a period)
	SCI_REGEX = /\A[A-Z]{1}[a-z]+\s{1}(?:[a-z]+|sp\.)\Z/
		#A capital followed by lowercase 1 space and the rest lowercase letters or sp.
	COM_REGEX = /\A[A-Z][a-z]+(?:\s[A-Z][a-z\.]+)*?\Z/

	validates :comname,
		:allow_blank => true,
		:format => {
			:with => COM_REGEX,
			:message => 'must contain only spaces letters and periods'
		}

	validates :species_cd, :presence => true,
	  :format => {:with => CD_REGEX,
	  :message => 'must be capitalized, with first 4 letters
	  of the genus and first 3 of the species'},
	  :uniqueness => true

	 validates :sciname, :presence => true,
	 	:format => {
	 		:with => SCI_REGEX,
	 		:message => 'must be a valid scientific name'
	 	}
end
