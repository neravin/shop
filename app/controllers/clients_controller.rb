class ClientsController < ApplicationController
  skip_before_action :authorize#, only: :composition
  # GET /clients/new
  def new
    @client = Client.new
  end
end
