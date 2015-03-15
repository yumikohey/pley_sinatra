get '/' do
	@lowscore_biz = Inspection.where("score < ?", 50)
	@client = Yelp::Client.new({ 
				   consumer_key: ENV['CONSUMER_KEY'],
                   consumer_secret: ENV['CONSUMER_SECRET'],
                   token: ENV['TOKEN'],
      	           token_secret: ENV['TOKEN_SECRET']
              })
	@restaurants = @client.search('San Francisco', {term: session[:search_value]})
	erb :index
end

post '/' do
	session[:lat] = params[:latitude]
	session[:longitude] = params[:longitude]
	session[:search_value] = params[:search_info]
	if request.xhr?
		{lat: session[:lat], longitude: session[:longitude]}.to_json
	else
	   redirect "/"
	end
end


# coordinates = { latitude: 37.7577, longitude: -122.4376 }
# client.search_by_coordinates(coordinates, params, locale)