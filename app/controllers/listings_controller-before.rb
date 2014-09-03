class ListingsController < ApplicationController

	def create
		require 'open-uri'
		search_id = params[:id]
		search = Search.find(search_id)
		listing = Listing.new 

		cities = City.all.where(country: "us")
		city_name = "albany"
  	web_url = "http://#{city_name}.craigslist.org/search/web?query=+"
  	origin_url = "http://#{city_name}.craigslist.org"
    listings = Nokogiri::HTML(open(web_url))

	    listings.css(".row").each do |listing|
	    	date = listing.children[3].children[3].children[1].children[0].to_s
	    	title = listing.children[3].children[3].children[3].children[0].to_s
	    	body_path = listing.children[3].children[3].children[3].attributes["href"].value
	    #################################								
	      body_page_url = origin_url + body_path
	    	body_page = Nokogiri::HTML(open(body_page_url))	
	    	yacht = "grow"			
	    	binding.pry			
	    	title = body_page.css("#postingtitle").to_s.match(/#{yacht}/)
	    	body = body_page.css("#postingbody").to_s.match(/#{yacht}/)
	    	#if title and body are both not nil then switch to 

	    	accept_keywords = params[:accept]
	    	decline_keywords = params[:reject]

	    	accept_array = accept_keywords.split(' ')
	    	decline_array = decline_keywords.split(' ')

	    	accept_validation = false
	    	reject_validation = false

	    	accept_array.each do |keyword|
	    		binding.pry
	    		unless accept_validation == nil
	    		  accept_validation = body_page.to_s.match(/#{keyword}/)
	    		  if accept_validation != nil
	    		  end
	    	  end
	    	end

	    	decline_array.each do |keyword|
	    		binding.pry
	    		unless accept_validation == nil
	    		  accept_validation = body_page.to_s.match(/#{keyword}/)
	    	  end
	    	end
	    end
  	
		binding.pry
	end
end
