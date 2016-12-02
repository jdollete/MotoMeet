get '/sessions/new' do
  erb :'sessions/new'
end

post '/sessions' do
  user = User.find_by_email(params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    # redirect "/users/#{user.id}"
    redirect "/"
  else
    @errors = ["Email and password did not match"]
    erb :'/sessions/new'
  end
end

delete '/sessions' do
  session.clear
  redirect '/'
end
