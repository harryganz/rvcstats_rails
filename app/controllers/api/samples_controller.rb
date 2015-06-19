class Api::SamplesController < ApplicationController
  def index
  	@samples = Sample.with_species(query_params[:species]).with_year(
    query_params[:year]).with_region(query_params[:region]).with_stratum(
    query_params[:strat]).is_protected(query_params[:prot]).when_present(
    query_params[:present])
  end

  private
	# Whitelist queryable params
	def query_params
		raise 'prot cannot have more than one argument' if params[:prot].present? &&
     params[:prot].length > 1
		raise 'present cannot have more than one argument' if params[:present].present?
     && params[:present].length > 1
		params.permit(:species => [], :year => [], :region => [], :strat => [],
     :prot => [], :present => [])
	end
end
