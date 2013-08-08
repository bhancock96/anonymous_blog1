get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/create' do

  erb :create
end

get 'post/:id' do
end

get '/tags' do
end



# ********** POST ROUTES ****************

post '/create' do
end

post '/post/:id/edit' do
end

post '/post/:id/delete' do
end
