class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  before_action :set_client, only: [:new, :edit, :destroy]
  after_action :verify_authorized, except: :index

  def index
    @invoices = Invoice.includes(:client).where(clients: { user_id: current_user.id })
  end

  def show
    authorize @invoice

  end

  def new
    @invoice = Invoice.new
    authorize @invoice
  end
  
  def create
    client_id = params[:client_id]
    @invoice = Invoice.new(invoice_params)
    @invoice.client_id = client_id
    authorize @invoice
    if @invoice.save
      redirect_to client_invoices_path(client_id: client_id), notice: "Invoice created"
    else
      render :new
    end
  end

  def edit
    authorize @invoice
  end

  def update
    authorize @invoice
    if @invoice.update(invoice_params)
      redirect_to client_invoices_path(client_id: @invoice.client_id), notice: "Invoice updated"
    else
      render :edit
    end
  end

  def destroy
    authorize @invoice
    @invoice.destroy
    redirect_to client_invoices_path
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def set_client
    @client = Client.find(params[:client_id])
  end

  def invoice_params
    params.require(:invoice).permit(:vat, :notes, services_attributes: [:description, :amount, :_destroy, :id])
  end
end
