class ListingsController < ApplicationController
	require 'nokogiri'
	require 'open-uri'

	def index
		@listings = Listing.all
	end

	def create
		search_id = params[:id]
		search = Search.find(search_id)
		

		cities = City.all.where(country: "US").first(30)
  	
    
    	cities.each do |city|
    		web_url = "http://#{city.city}.craigslist.org/search/web?query=+"
  			origin_url = "http://#{city.city}.craigslist.org"
				  begin
				    		listings = Nokogiri::HTML(open(web_url))
										    listings.css(".row").each do |listing|
										    	new_listing = Listing.new 
										    	date = listing.children[3].children[3].children[1].children[0].to_s
										    	title = listing.children[3].children[3].children[3].children[0].to_s
										    	body_path = listing.children[3].children[3].children[3].attributes["href"].value
										    #################################								
										      body_page_url = origin_url + body_path
										    	body_page = Nokogiri::HTML(open(body_page_url))	

										    	# email = binding.pry

										    	accept_keywords = search.accepted
										    	decline_keywords = search.denied
										    	accept_array = accept_keywords.split(' ')
										    	decline_array = decline_keywords.split(' ')

										    	accept_validation = false
										    	reject_validation = false

										    	@accept_status = false
										    	accept_array.each do |keyword|
										    		accept_validation = body_page.to_s.match(/#{keyword}/)
										    		if accept_validation == nil
										    			@accept_status = false
										    		else
										    			@accept_status = true
										    	  end
										    	end

										    	@decline_status = 0
										    	decline_array.each do |keyword|
										    		accept_validation = body_page.to_s.match(/#{keyword}/)
										    		if accept_validation != nil
										    			@decline_status += 1
										    		end
										    	end

										    	if @decline_status == decline_array.count
										    		@decline_status = true
										    	else 
										    		@decline_status = false
										    	end

											    if @accept_status && @decline_status
											      new_listing.city = city.city
											      new_listing.title = title
											      binding.pry
											      new_listing.body_page = body_page.text
											      new_listing.body = body_page.css('#postingbody').text
											      new_listing.search_id = search.id
											      new_listing.city_id =  city.id
											      new_listing.user_id = 1
											      new_listing.save
											    end

										    end # end of listing
					rescue => e

					end
  		end # end of city iteration
		
	end
end
