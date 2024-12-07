class ClientsController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: :index
  before_action :set_client, only: [:show, :edit, :update, :deactivate]

  def index
    @clients = current_user.clients.where(status: true)
    if params[:query].present?
      sql_subquery = "name ILIKE :query OR email ILIKE :query"
      @clients = current_user.clients.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
    @clients = current_user.clients
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
      redirect_to client_path(@client), notice: 'Client successful created'
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
      redirect_to client_path(@client), notice: "Client successful updated"
    else
      render :edit
    end
  end

  def deactivate
    authorize @client
    @client.status = false
    @client.save
    redirect_to clients_path, notice: "Client successful deleted"
  end


  # def destroy
  #   authorize @client
  #   @client.destroy
  #   redirect_to clients_path, notice: "Client successful deleted"
  # end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def clients_params
    params.require(:client).permit(:name, :address, :county, :email, :postcode, :phone)
  end

end
