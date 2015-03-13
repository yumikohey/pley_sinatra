get '/login' do
  erb :"/user/login"
end

post '/login' do
  @user = User.find_by(email: params[:user][:email])

  if @user && @user.authenticate(params[:user][:password])
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    @user = User.new
    @user.errors.add(:login, "Username or Password did not match.")
    erb :"/user/login"
  end
end

get '/logout' do
  session[:user_id] = nil

  redirect '/'
end

get '/user/register' do
  erb :"/user/register"
end

post '/user/register' do
  @user = User.create(params[:user])

  if @user.errors.empty?
    session[:user_id] = @user.id
    redirect '/'
  else
    erb :"/user/register"
  end
end

