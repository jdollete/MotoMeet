get '/events' do
  @events = Event.upcoming.order(start_at: :asc)
  erb :'events/show'
end


get '/events/new' do
  if logged_in?
    erb :'events/new'
  else
    @errors = "Please log in"
    redirect '/sessions/new'
  end
end

post '/events' do
  binding.pry
  if logged_in?
    @event = Event.new(params[:event])
    @event.assign_attributes(address: "#{params[:street_address]}, #{params[:city]}, #{params[:state]}", user_id: current_user.id)
      if @event.save
        redirect "/events/#{@event.id}"
      else
        @errors = event.errors.full_messages
        erb :'/events/new'
      end

  else
    @errors = "You must be logged in to do this"
    redirect '/sessions/new'
  end

end

# Edits the event post
get '/events/:id/edit' do
  @event = Event.find_by_id(params[:id])
  post_owner = User.find_by_id(@event.user_id)
  if authorized?(post_owner)
    erb :'events/edit'
  else
    @errors = "You must be logged in to do that"
    redirect '/sessions/new'
  end
end

put '/events/:id' do
  post_owner = User.find_by_id(Event.find_by_id(params[:id]).user_id)
  if authorized?(post_owner)
    @event = Event.find_by_id(params[:id])
    @event.assign_attributes(params[:potluck])
    if @event.save
      redirect "/events/#{@event.id}"
    else
      @errors = event.errors.full_messages
      erb :'events/edit'
    end
  else
    @errors = "You must be logged in to do that"
    redirect '/sessions/new'
  end
end

delete '/events/:id' do
  if authorized?(post_owner(params[:id]))
    @event = Event.find_by_id(params[:id])
    if @event.destroy
      redirect '/'
    else
      @errors = event.errors.full_messages
      redirect "/events/#{@event.id}"
    end
  else
    @errors = "You must be logged in to do that"
    redirect '/sessions/new'
  end
end

get '/events/:id' do
  @event = Event.find_by_id(params[:id])
  @post_owner = User.find_by_id(@event.user_id)
  @commiters = Commitment.all
  erb :'events/show'
end
