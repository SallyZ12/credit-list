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
          if params[:credit][:credit_name] == "" || params[:credit][:sector] == "" || params[:credit][:rating] == ""
            flash[:message] = "Credit Data Missing - Try Again"
              redirect '/credits/new'
            else
              if params["transaction"]["name"] == "" || params["transaction"]["series"] == ""
                flash[:message] = "Transaction Data Missing - Try Again"
                redirect '/credits/new'
              end
          @credit = current_user.credits.build(credit_name: params[:credit][:credit_name], sector: params[:credit][:sector], rating: params[:credit][:rating])

        if !params["transaction"]["name"].empty? & !params["transaction"]["series"].empty?
          @credit.transactions << Transaction.create(params[:transaction])
            @credit.save
              redirect "/credits/#{@credit.id}"
            end
      end
    end
  end


   get '/credits/:id' do
     if logged_in?
         @credit = Credit.find_by_id(params[:id])
        if @credit.user_id != current_user.id
          flash[:message] = "Access Denied"
          redirect '/'
        else
          erb :'/credits/show_credit'
        end
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
        redirect '/login'
  end
end



   delete '/credits/:id/delete' do
     if logged_in?
       @credit = Credit.find_by_id(params[:id])
        if !@credit.transactions.ids.empty?
          flash[:message] = "To Delete A Credit You Must Delete the linked Transactions First! Select a Transaction."
          redirect "/credits/#{@credit.id}"
        else
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

  end
