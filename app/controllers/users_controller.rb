class UsersController < ApplicationController
  use Rack::Flash

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect '/credits'
    end
  end


  post '/signup' do

    if params[:username] == "" || params[:password] == ""
      flash[:message] = "Missing Information - Please Try Again"
      redirect '/signup'
    else
      @user = User.new(username: params[:username]), password: params[:password])
      @user.save

      session[:user_id] = @user.id
      redirect '/credits'
    end
  end

  end

end
