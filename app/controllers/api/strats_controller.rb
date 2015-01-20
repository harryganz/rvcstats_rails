class Api::StratsController < ApplicationController
  def index
  	@strata = Strat.where(query_params)
  end

  private 
  	#Whitelist allowed parameters
  	def query_params 
  		raise 'prot cannot have more than one argument' if params[:prot].present? && params[:prot].length > 1
  		params.permit(:strat => [], :region => [], :year => [], :prot => [])
  	end
end
