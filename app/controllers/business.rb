get '/:business_id' do
	@biz = Business.where(business_id: params[:business_id])[0]
	@biz_inspec = Inspection.where(business_id: params[:business_id])
	count = 1
	@score = 0
	@biz_inspec.each do |biz_s|
		if biz_s.score != nil
			@score += biz_s.score
			count += 1
		else
			@score
		end
	end
	if count == 1
		@score = @score / count
	else
		@score = @score / (count-1)
	end
	@client = Yelp::Client.new({ 
				   consumer_key: ENV['CONSUMER_KEY'],
                   consumer_secret: ENV['CONSUMER_SECRET'],
                   token: ENV['TOKEN'],
      	           token_secret: ENV['TOKEN_SECRET']
              })

	concate_business_name = @biz.name.split(' ').join('-')
	business_yelp_id = concate_business_name + '-san-francisco'
	@result = @client.business(business_yelp_id)

	@comments = Comment.where(business_id: params[:business_id])
	erb :"business/profile"
end

post '/:business_id' do
	comment = Comment.create!(
		content: params[:content],
		business_id: params[:business_id],
		user_id: User.find(session[:user_id]).id
		)
	user = User.find(session[:user_id]).screen_name
	# require 'pry-debugger'
	# binding.pry

	if request.xhr?
	   content_type :json
	   {screen_name: user, content: comment.content}.to_json
	else
	   redirect "/#{params[:business_id]}"
	end
end

get '/business/nearby_restaurants' do
	@client = Yelp::Client.new({ 
				   consumer_key: ENV['CONSUMER_KEY'],
                   consumer_secret: ENV['CONSUMER_SECRET'],
                   token: ENV['TOKEN'],
      	           token_secret: ENV['TOKEN_SECRET']
              })
	bounding_box = { sw_latitude: session[:lat].to_f - 0.05, sw_longitude: session[:longitude].to_f - 0.05, ne_latitude: session[:lat].to_f + 0.05, ne_longitude: session[:longitude].to_f + 0.05 }
	features = { term: 'Chinese',
	             limit: 15
	         }
	@restaurants = @client.search_by_bounding_box(bounding_box, features)
	erb :"/business/nearby"
end
