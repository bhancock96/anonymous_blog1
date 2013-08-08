get '/tag/:id' do
  @tag = Tag.find(params[:id])
  erb :tag
end
