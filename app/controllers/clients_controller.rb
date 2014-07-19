class ClientsController < ApplicationController
  skip_before_action :authorize#, only: :composition
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  # GET /clients/new
  def new
    @client = Client.new
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end
end
