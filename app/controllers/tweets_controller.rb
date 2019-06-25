class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_signed_in?(session)
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/users/login'
    end
  end

  get '/tweets/new' do
    user = Helpers.current_user(session)
    if user.nil?
      redirect to '/login'
    else
      erb :'/tweets/create_tweet'
    end
  end

  post '/tweets' do
    user = Helpers.current_user(session)
    if user.nil?
      redirect to '/login'
    elsif params[:tweet][:content].empty?
      redirect to '/tweets/new'
    else
      user.tweets.new({content: params[:tweet][:content]})
      user.save
    end
    redirect to 'tweets'
  end

  get 'tweets/:id' do
    if Helpers.is_signed_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_user_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.is_signed_in?(session) &&
       @tweet.user == Helpers.current_user(session)
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect to '/login'
  end











end
