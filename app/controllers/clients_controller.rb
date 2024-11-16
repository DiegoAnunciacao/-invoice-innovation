class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  def index
    @clients = Client.where(user: current_user)
  end

  def show
    authorize @client
  end

  def new
    @client = Client.new
    authorize @client
  end

  def create
    @client = Client.new(clients_params)
    @client.user = current_user
    authorize @client
    if @client.save
      redirect_to clients_path, notice: 'Client created'
    else
      render :new
    end
  end

  def edit
    authorize @client
  end

  def update
    authorize @client
    if @client.update(clients_params)
      redirect_to clients_path, notice: "Client updated"
    else
      render :edit
    end
  end

  def destroy
    authorize @client
    @client.destroy
    redirect_to clients_path
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def clients_params
    params.require(:client).permit(:client_name, :client_address, :client_county, :client_email, :client_postcode, :client_phone)
  end

end
