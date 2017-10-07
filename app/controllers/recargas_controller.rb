class RecargasController < ApplicationController
  before_action :authenticate_user!
  before_action :usuario_autorizado
  before_action :saldo_sms
  before_action :set_recarga, only: [:show, :edit, :update, :destroy]

  def usuarios
    @usuarios = User.all
    @total = @usuarios.length
  end

  def usuario
    @usuario = User.find(params[:id])
  end

  # GET /recargas
  # GET /recargas.json
  def index
    @recargas = Recarga.all
  end

  # GET /recargas/1
  # GET /recargas/1.json
  def show
  end

  # GET /recargas/new
  def new
    @recarga = Recarga.new
  end

  # GET /recargas/1/edit
  def edit
  end

  # POST /recargas
  # POST /recargas.json
  def create
    @recarga = Recarga.new(recarga_params)

    respond_to do |format|
      if @recarga.save
        format.html { redirect_to @recarga, notice: 'Recarga was successfully created.' }
        format.json { render :show, status: :created, location: @recarga }
      else
        format.html { render :new }
        format.json { render json: @recarga.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recargas/1
  # PATCH/PUT /recargas/1.json
  def update
    respond_to do |format|
      if @recarga.update(recarga_params)
        format.html { redirect_to @recarga, notice: 'Recarga was successfully updated.' }
        format.json { render :show, status: :ok, location: @recarga }
      else
        format.html { render :edit }
        format.json { render json: @recarga.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recargas/1
  # DELETE /recargas/1.json
  def destroy
    @recarga.destroy
    respond_to do |format|
      format.html { redirect_to recargas_url, notice: 'Recarga was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recarga
      @recarga = Recarga.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recarga_params
      params.require(:recarga).permit(:monto_divisa, :tipo_divisa, :cambio_bs, :monto_bs, :banco_origen, :referencia_origen, :transaccion_origen, :banco_destino, :referencia_destino, :transaccion_destino, :aplicado, :user_id)
    end
end
