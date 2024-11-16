class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  before_action :set_client, only: [:new, :edit, :destroy]
  def index
    @invoices = Invoice.where(user: current_user)
  end

  def show
    authorize @invoice
  end

  def create
    client_id = params[:client_id]
    @invoice = Invoice.new(invoice_params)
    @invoice.client_id = client_id
    if @invoice.save
      redirect_to client_invoices_path(client_id: client_id), notice: "Invoice created"
    else
      render :new
    end
  end

  def new
    @invoice = Invoice.new
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
    authorize @client
    @invoice.destroy
    redirect_to client_path(@client)
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def set_client
    @client = Client.find(params[:client_id])
  end

  def invoice_params
    params.require(:invoice).permit(:vat, :notes)
  end

end
