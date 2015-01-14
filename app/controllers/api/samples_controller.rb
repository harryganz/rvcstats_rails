class Api::SamplesController < ApplicationController
  def index
  	@samples = Sample.with_species(query_params[:species]).with_year(query_params[:year]).with_region(query_params[:region]).with_stratum(query_params[:stratum]).is_protected(query_params[:protected]).when_present(query_params[:present])
  end

  private
	# Whitelist queryable params
	def query_params 
		params.permit(:species => [], :year => [], :region => [], :stratum => [], :protected => [], :present => [])
	end
end