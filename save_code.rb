<% while i < length %>
  <% if (biz_vios[i].date + 60.minutes).utc > (biz_vios[i+1].date + 60.minutes).utc %>
      <% temp = biz_vios[i] %>
      <% biz_vios[i] = biz_vios[i+1] %>
      <% biz_vios[i+1] = temp %>
    <% end %>
  <% i += 1 %>
<% end %>

	<% @result.businesses.each do |biz| %>
		<div class="row">
			<%= biz.name %>
		</div>
	<% end %>

@client = Yelp::Client.new({ 
				   consumer_key: ENV['CONSUMER_KEY'],
                   consumer_secret: ENV['CONSUMER_SECRET'],
                   token: ENV['TOKEN'],
      	           token_secret: ENV['TOKEN_SECRET']
              })
	features = { term: session[:search_value],
	             limit: 10
	           }

	@result = @client.search('San Francisco', features)

<% biz = Business.where("name LIKE ?": "%#{biz_name}%")[0]%>
	<div class="row">
		<div class="col-md-2">
			<%= erb :view_360, :locals => { :biz => biz } %>
		</div>

		<div class="col-md-7 col-md-offset-2">
		   <h2><a href="/<%= biz.business_id%>"><%= biz.name.titleize %></a></h2>
		   <%= erb :biz_vio_desc, :locals => { :biz_id => biz_id } %>
		</div>
	</div>


