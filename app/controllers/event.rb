get '/events' do
  @events = Event.upcoming.order(starts_at: :asc)
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
  if logged_in?
    @event = Event.new(params[:event])
    @event.assign_attributes(address: "#{params[:street_address]}, #{params[:city]}, #{params[:state]}", state: params[:state], user_id: current_user.id)
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
    binding.pry
    @event.assign_attributes(params[:event])
    @event.assign_attributes(address: "#{params[:street_address]}, #{params[:city]}, #{params[:state]}", state: params[:state], user_id: current_user.id)
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
  @committers = Commitment.all
  json_string_response = open("https://maps.googleapis.com/maps/api/geocode/json?address=" + @event[:address].gsub(/ /, '+') + "&key=AIzaSyDGh4J2RKsYF8c83RREWX-h10VW1TLMbwE").read
  ruby_hash_response = JSON.parse(json_string_response)
  @lat = ruby_hash_response["results"][0]["geometry"]["bounds"]["northeast"]["lat"]
  @lng = ruby_hash_response["results"][0]["geometry"]["bounds"]["northeast"]["lng"]
  erb :'events/show_single'
end
