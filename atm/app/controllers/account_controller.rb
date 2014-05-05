class AccountController < ApplicationController
  
  def index
    @accounts = get_accounts
  end

  def show
    @account = get_account(params[:id])
    @withdraw_uri = @account['links'].find { |h| h['type'] == "withdraw" }['uri']
  end

  def withdraw
    credentials = get_credentials
    response = WithdrawAPIRequest.call(credentials, params[:amount], params[:endpoint])
  end

  private 

    def get_accounts
      credentials = get_credentials
      AccountsAPIRequest.call(credentials).data
    end

    def get_account(id)
      credentials = get_credentials
      response = AccountsAPIRequest.call(credentials)
      response.data.find { |h| h['id'] == id.to_i }
    end

end
