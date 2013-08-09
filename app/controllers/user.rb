get '/users/:id' do
  @user = User.find(params[:id])
  if @user.id = current_user.id
    erb :profile
  else
    erb :login_register
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end





# ********POST ROUTES********************

post '/login' do
  @user = User.login(params)
  puts @user
  puts
  puts
  session[:user_id] = @user.id
  redirect "/users/#{@user.id}"
end

post '/register' do
  user = User.new(password: params[:user][:password],
                  email: params[:user][:email],
                  name: params[:user][:name])
  user.save
  session[:user_id] = user.id
  redirect "/users/#{user.id}"
end
