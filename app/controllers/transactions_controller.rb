class TransactionsController < ApplicationController
  use Rack::Flash


  get '/transactions' do
    @transactions = Transaction.all

    erb :'/transactions/all_transactions'
  end


  get '/transactions/new' do
    @credits = Credit.all
    erb :'/transactions/new_transaction'
  else
    redirect '/login'
  end


end
