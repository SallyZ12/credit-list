require 'pry'
class CreditsController < ApplicationController
   use Rack::Flash

   get '/credits' do
     if logged_in?
      @credits = Credit.all
      erb :'/credits/all_credits'
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

   post '/credits' do
     if logged_in?
       if params[:credit_name]== ""|| params[:sector] == "" || params[:rating] == ""
         flash[:message] = "Missing Data - Try Again"
         redirect '/credits/new'
       else
         @credit = current_user.credits.build(credit_name: params[:credit_name], sector: params[:sector], rating: params[:rating])
         @credit.save

        redirect "/credits/#{@credit.id}"
      end
    end
   end

   get '/credits/:id' do
     if logged_in?
       @credit = Credit.find_by_id(params[:id])
       erb :'/credits/show_credit'
     else
       redirect '/login'
     end
   end



 end
