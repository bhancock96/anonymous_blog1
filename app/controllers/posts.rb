
get '/create' do
  erb :create
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
  @tags = []
  @post.tags.each do |tag|
    @tags << tag.name
  end
  @tags
  erb :edit
end

get '/post/:id/delete' do
  @post = Post.find(params[:id])
  @post.destroy
  redirect "/posts" 
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
  @post = Post.create(title: params[:post][:title], body: params[:post][:body])
  tags = params[:post][:tags]
  tags.split(', ').each do |tag|
    new_tag = Tag.find_or_create_by_name(tag)
    @post.tags << new_tag
  end
  @post.save
  redirect '/posts'
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


