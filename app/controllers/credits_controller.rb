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
       @transactions = Transaction.all
       erb :'/credits/new_credit'
     else
       redirect '/login'
     end
   end

   post '/credits' do
     if logged_in?
       if params[:credit][:credit_name]== ""|| params[:credit][:sector] == "" || params[:credit][:rating] == "" || params[:transaction][:name] == "" || params[:transaction][:series] == "" || params[:transaction][:par] == ""
         flash[:message] = "Missing Data - Try Again"
         redirect '/credits/new'
       else
         @credit = current_user.credits.build(credit_name: params[:credit][:credit_name], sector: params[:credit][:sector], rating: params[:credit][:rating])
         if !params["transaction"]["name"].empty? & !params["transaction"]["series"].empty? & !params["transaction"]["par"].empty?
           @credit.transactions << Transaction.create(name: params["transaction"]["name"], series: params["transaction"]["series"], par: params["transaction"]["par"])
       end
        @credit.save
        binding.pry
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

   get '/credits/:id/edit' do
     if logged_in?
       @credit = Credit.find_by_id(params[:id])
       if @credit.user_id == current_user.id
         erb :'/credits/edit_credit'
       end
     else
       redirect '/login'
     end
   end

   patch '/credits/:id' do
     if logged_in?
       if params[:credit][:credit_name] == "" || params[:credit][:sector] == "" || params[:credit][:rating] == ""
         redirect "/credits/#{params[:id]}/edit"
       else
          @credit = Credit.find_by_id(params[:id])
            if @credit.user_id == current_user.id
              if @credit.update(credit_name: params[:credit][:credit_name], sector: params[:credit][:sector], rating: params[:credit][:rating])
                flash[:message] = "Credit Edited"
                redirect "/credits/#{@credit.id}"
              else
                redirect "/credits/#{@credit.id}/edit"
              end
          else
            redirect '/credits'
          end
        end
      else
        redirect '/login'
      end
   end

   delete '/credits/:id/delete' do
     if logged_in?
       @credit = Credit.find_by_id(params[:id])
        if @credit.user_id == current_user.id
          @credit.delete
          flash[:message] = "Credit Deleted"
          redirect "/users/show_user_credits"
        else
          redirect '/login'
        end
      end
    end

  end
