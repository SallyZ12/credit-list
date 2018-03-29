class UsersController < ApplicationController
  use Rack::Flash

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show_user_credits'
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
      @user = User.new(username: params[:username], password: params[:password])
      @user.save

      session[:user_id] = @user.id
      redirect '/credits'
    end
  end


  get '/login' do
     if !logged_in?
       erb :'users/login'
     else
       redirect '/credits'
     end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect 'users/show_user_credits'
    else
      flash[:message] = "Login Failed, Please Try Again (You May Need to Sign-Up)"
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect '/login'
    else
      redirect '/'
    end
  end

end
