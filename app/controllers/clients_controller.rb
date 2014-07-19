class ClientsController < ApplicationController
  skip_before_action :authorize#, only: :composition
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  # GET /clients/new
  def new
    @client = Client.new
  end

  def show
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        flash[:success] = "Добро пожаловать в интернет магазин";
        format.html { redirect_to clients_url, notice: "Пользователь #{@client.name} был успешно создан." }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :email, :password, :password_confirmation)
    end
end
