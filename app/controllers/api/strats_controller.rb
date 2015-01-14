class Api::StratsController < ApplicationController
  def index
  	@strata = Strat.where(query_params)
  end

  private 
  	#Whitelist allowed parameters
  	def query_params 
  		params.permit(:strat => [], :region => [], :year => [], :protected => [])
  	end
end
