get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/create' do

  erb :create
end

get '/post/:id' do
  @post = Post.find(params[:id])
  erb :post
end

get '/tags' do
end

get '/posts' do
  @posts = Post.all
  erb :posts
end



# ********** POST ROUTES ****************

post '/create' do
  @post = Post.create(title: params[:post][:title], body: params[:post][:body])
  @post.tags.create(name: params[:post][:tags])
  @post.save
  redirect '/posts'
end

post '/post/:id/edit' do
end

post '/post/:id/delete' do
end
