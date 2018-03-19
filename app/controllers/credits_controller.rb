class CreditsController < ApplicationController
   use Rack::Flash

   get '/credits' do
     if logged_in?
      @credits = Credit.all
      erb :'/credits/credits'
    else
      redirect '/login'
    end
   end

   get '/credits/new' do
     if logged_in?
       erb :'/credits/create_credit'
     else
       redirect '/login'
     end
   end


 end
