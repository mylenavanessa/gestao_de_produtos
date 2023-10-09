class EstoquesController < ApplicationController
  before_action :set_estoque, only: [:show, :update, :destroy]

  # GET /estoques
  def index
    @estoques = Estoque.all

    render json: @estoques
  end

  # GET /estoques/1
  def show
    response = @estoque.attributes
    response[:data] = @estoque.created_at.strftime("%d/%m/%Y")
    response[:hora] = @estoque.created_at.strftime("%H:%M:%S")
    response.delete("created_at")
    response.delete("updated_at")
    render json: response
  end

  # POST /estoques
  def create
    @estoque = Estoque.new(estoque_params)

    if @estoque.save
      response = @estoque.attributes
      response[:data] = @estoque.created_at.strftime("%d/%m/%Y")
      response[:hora] = @estoque.created_at.strftime("%H:%M:%S")
      response.delete("created_at")
      response.delete("updated_at")
      render json: response, status: :created, location: @estoque
    else
      render json: @estoque.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /estoques/1
  def update
    if @estoque.update(estoque_params)
      render json: @estoque
    else
      render json: @estoque.errors, status: :unprocessable_entity
    end
  end

  # DELETE /estoques/1
  def destroy
    @estoque.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_estoque
      @estoque = Estoque.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def estoque_params
      params.permit(:tipo, :quantidade, :produto_id)
    end
end
