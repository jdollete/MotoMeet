post '/commitments/:user_id/events/:id' do
  @committer = Commitment.new(user_id: params[:user_id], event_id: params[:id])
  if @committer.save
  else
    @errors = committer.errors.full_messages
  end
  redirect "/events/#{params[:id]}"
end
