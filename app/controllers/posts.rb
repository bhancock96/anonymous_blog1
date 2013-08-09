# before '/*' do
  
#   post = Post.find(params[:id])
#   unless 
# end

get '/create' do
  if current_user
    @user = User.find(session[:user_id])
    erb :create
  else
    erb :login_register
  end
end

get '/post/:post_id/tag/:id/delete' do
  post = Post.find(params[:post_id])
  tag = post.tags.find(params[:id])
    post.delete_tag(tag)
    post.delete_tags_with_no_posts
  redirect "/post/#{post.id}" 
end

get '/post/:id/edit' do
  @post = Post.find(params[:id])
  if current_user && current_user.posts.include?(@post)
    @tags = []
    @post.tags.each do |tag|
      @tags << tag.name
    end
    @tags
    erb :edit
  else
    erb :login_register
  end
end

get '/users/:id/posts' do
  @user = User.find(params[:id])
  @posts = @user.posts.all
  erb :user_posts
end

get '/post/:id/delete' do
  @user = User.find(session[:user_id])
  @post = Post.find(params[:id])
  @post.destroy
  redirect "/users/#{@user.id}" 
end


get '/post/:id' do
    @post = Post.find(params[:id])
    erb :post
end

get '/posts' do
  @posts = Post.all
  erb :posts
end

#**************** POST ROUTES *************************


post '/create' do
  @user = User.find(session[:user_id])
  @post = @user.posts.create(title: params[:post][:title], body: params[:post][:body])
  tags = params[:post][:tags]
  tags.split(', ').each do |tag|
    new_tag = Tag.find_or_create_by_name(tag)
    @post.tags << new_tag
  end
  @post.save
  redirect "/users/#{@user.id}"
end

post '/post/:id/edit' do
  @post = Post.find(params[:id])
  @post.update_attributes(title: params[:title], body: params[:body])
  tags = params[:tags]
  tags.split(', ').each do |tag|
    new_tag = Tag.find_or_create_by_name(tag)
    @post.tags << new_tag
  end
  redirect "/post/#{@post.id}"
end


post '/users/id/posts' do
  @user = User.find_by_name(params[:name])
  redirect "/users/#{@user.id}/posts"
end
