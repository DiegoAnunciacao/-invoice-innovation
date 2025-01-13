class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show edit update destroy]
  before_action :set_client, only: %i[new create]
  after_action :verify_authorized, except: :index

  def index
    @invoices = Invoice.includes(:client).where(clients: { user_id: current_user.id }).order(created_at: :desc)
    if params[:query].present?
      sql_subquery = "name LIKE :query OR email LIKE :query"
      @invoices = @invoices.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def show
    authorize @invoice
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name"
      end
    end
  end

  def new
    @invoice = Invoice.new
    authorize @invoice
  end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.client_id = params[:client_id]
    authorize @invoice
    if @invoice.save
      redirect_to invoices_path, notice: "Invoice successful created"
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
      redirect_to invoice_path(@invoice), notice: "Invoice successful updated"
    else
      render :edit
    end
  end

  def destroy
    authorize @invoice
    @invoice.destroy
    redirect_to invoices_path, alert: "Invoice successful deleted"
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def set_client
    @client = Client.find(params[:client_id])
  end

  def invoice_params
    params.require(:invoice).permit(:vat, :notes, services_attributes: %i[description amount id _destroy])
  end
end
