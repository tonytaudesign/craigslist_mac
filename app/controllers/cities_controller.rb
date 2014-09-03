class CitiesController < ApplicationController
	def upload
		params_cities = city_params
		City.import params_cities[:file]
	end






	private

	def city_params
    params.permit(:file)
  end

end
