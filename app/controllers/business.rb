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
    # @result = @client.search_by_coordinates(coordinates, params)
	@result = @client.business(business_yelp_id)

	@comments = Comment.where(business_id: params[:business_id])
	erb :"business/profile"
end

post '/:business_id' do
	Comment.create!(
		content: params[:content],
		business_id: params[:business_id],
		user_id: User.find(session[:user_id]).id
		)
	redirect "/#{params[:business_id]}"
end