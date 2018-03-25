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
        if params[:transaction][:name]== "" || params[:transaction][:series] == ""

          flash[:message] = "Missing Data - Try Again"
            redirect '/transactions/new'
        else
          @transaction = Transaction.create(params[:transaction])
            if !params["credit"]["credit_name"].empty? & !params["credit"]["sector"].empty? & !params["credit"]["rating"].empty?
            @transaction.save
          else
              @transaction.credit = Credit.create(credit_name: params[:credit][:credit_name], sector: params[:credit][:sector], rating: params[:credit][:rating])
          end
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
        erb :'/transactions/edit_transaction'

    else
        redirect '/login'
      end
    end

    patch '/transactions/:id' do
      if logged_in?
        if params[:transaction][:name] == ""|| params[:transaction][:series] == ""
          redirect "/credits/#{params[:id]}/edit"
        else
          @transaction = Transaction.find_by_id(params[:id])
              @transaction.update(name: params[:transaction][:name], series: params[:transaction][:series])
                flash[:message] = "Transaction Edited"
                redirect "/transactions/#{@transaction.id}"
          end

        redirect '/login'
      end
    end



    delete '/transactions/:id/delete' do
      if logged_in?
        @transaction = Transaction.find_by_id(params[:id])
            @transaction.delete
              flash[:message] = "Transaction Deleted"
                redirect '/transactions'
              else
                redirect '/login'
              end
          end


end
