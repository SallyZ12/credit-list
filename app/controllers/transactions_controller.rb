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
          redirect '/transactions/new'
        else
      @transaction = current_user.transaction.create[name: params[:transaction][:name], series: params[:transaction][:series], par: params[:transactions][:par]]
        @transaction.credit = Credit.create(credit_name: params[:credit][:credit_name], sector: params[:credit][:sector], rating: params[:credit][:rating])
          @transaction.save
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
      if @credit.user_id == current_user.id
        erb :'/transactions/edit_transaction'
      end
    else
        redirect '/login'
      end
    end

    patch '/transaction/:id' do
      if logged_in?
        if params[:transaction][:name] == ""|| params[:transactions][:series] == "" || params[:transactions][:par] == ""
          redirect "/credits/#{params[:id]}/edit"
        else
          @transaction = Transaction.find_by_id(params[:id])
            if @credit.user_id == current_user.id
              if @transaction.update(name: params[:transaction][:name], series: params[:transaction][:series], par: [:transaction][:par])
                flash[:message] = "Transaction Edited"
              else
                redirect "/transactions/#{@transaction.id}"
              end
            else
              redirect '/transactions'
            end
          end
        else
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
end
