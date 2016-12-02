get '/users/new' do
  erb :'users/new'
end

post '/users' do
  user = User.new(params[:user])
  if user.save
    session[:user_id] = user.id
    redirect "/users/#{user.id}"
  else
    @errors = user.errors.full_messages
    erb :'users/new'
  end
end

get '/users/:id' do
  if logged_in?
    @user = User.find_by_id(params[:id])
    erb :'users/show'
  else
    @errors = "Please log in"
  end
end
