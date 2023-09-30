class ClientesController < ApplicationController
  before_action :set_cliente, only: [:show, :update, :destroy]

  # GET /clientes
  def index
    @clientes = Cliente.all

    render json: @clientes
  end

  # GET /clientes/1
  def show
    response = {}
    response[:cliente] = {}
    response[:cliente][:id] = @cliente.id
    response[:cliente][:nome] = @cliente.nome
    response[:cliente][:cnpj] = @cliente.cnpj
    response[:cliente][:email] = @cliente.email
    response[:cliente][:telefone] = @cliente.telefone

    produtos = @cliente.produtos

    response[:produtos] = []
    produtos.each do |produto|
      produto_obj = {}
      produto_obj[:nome] = produto.nome
      produto_obj[:descricao] = produto.descricao
      produto_obj[:quantidade] = produto.quantidade
      produto_obj[:preco] = produto.preco

      response[:produtos] << produto_obj
    end


    render json: response
  end

  # POST /clientes
  def create
    @cliente = Cliente.new(cliente_params)

    if @cliente.save
      render json: @cliente, status: :created, location: @cliente
    else
      render json: @cliente.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clientes/1
  def update
    if @cliente.update(cliente_params)
      render json: @cliente
    else
      render json: @cliente.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clientes/1
  def destroy
    @cliente.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cliente
      @cliente = Cliente.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cliente_params
      params.permit(:nome, :cnpj, :email, :telefone)
    end
end
