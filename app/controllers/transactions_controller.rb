require 'pry'
class TransactionsController < ApplicationController
  use Rack::Flash


  get '/transactions' do
    @transactions = Transaction.all

    erb :'/transactions/all_transactions'
  end


  get '/transactions/new' do
    if logged_in?
    @credits = Credit.all
    erb :'/transactions/new_transaction'
  else
    redirect '/login'
  end
end

  post '/transactions' do
    if logged_in?
        if params[:transaction][:name]== "" || params[:transaction][:series] == "" || params[:transaction][:par] == ""
          flash[:message] = "Missing Data - Try Again"
          redirect '/transactions/new'
        else
          @transaction = Transaction.create(params[:transaction])
          @transaction.credit = Credit.create(params[:credit])

          @transaction.save
          binding.pry
          redirect "/transactions/#{@transaction.id}"
    end
  end
end


  get '/transactions/:id' do
    if logged_in?
    @transaction = Transaction.find_by_id(params[:id])
    erb :'/transactions/show_transaction'
  else
    redirect '/login'
  end
end

  get '/transactions/:id/edit' do
    if logged_in?
      @transaction = Transaction.find_by_id(params[:id])
        erb :'/transactions/edit_transaction'

    else
        redirect '/login'
      end
    end

    patch '/transactions/:id' do
      if logged_in?
        if params[:transaction][:name] == ""|| params[:transactions][:series] == "" || params[:transactions][:par] == ""
          redirect "/credits/#{params[:id]}/edit"
        else
          @transaction = Transaction.find_by_id(params[:id])
              @transaction.update(name: params[:transaction][:name], series: params[:transaction][:series], par: [:transaction][:par])
                flash[:message] = "Transaction Edited"
                redirect "/transactions/#{@transaction.id}"
          end

        redirect '/login'
      end
    end



    delete '/transactions/:id/delete' do
      if logged_in?
        @transaction = Transaction.find_by_id(params[:id])
          if @credit.user_id == current_user.id
            @transaction.delete
              flash[:message] = "Transaction Deleted"
                redirect "/user/show_user_credits"
              else
                redirect '/login'
              end
            end
          end

end
