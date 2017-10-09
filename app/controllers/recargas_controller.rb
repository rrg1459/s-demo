class RecargasController < ApplicationController
  before_action :authenticate_user!
  before_action :usuario_autorizado
  before_action :saldo_sms
  before_action :set_recarga, only: [:aplicar, :show, :edit, :update, :destroy]

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
    @usuario = User.find(@recarga.user_id)
  end

  def recargar
    @usuario = User.find(params[:id])
    @recarga = Recarga.new
  end

  def aplicar
# verificar si es campanna    
    @usuario = User.find(@recarga.user_id)
    nuevo_saldo = @usuario.saldo + @recarga.monto_bs
    if !@recarga.f_aplicado
      @usuario.update_columns(saldo: nuevo_saldo)
      @recarga.update_columns(f_aplicado: Time.now)
      mensaje = 'Recarga fue aplicada al usuario'
    else
      mensaje = 'No se aplicó la recarga al usuario, porque ya estaba aplicada'
    end
#    buscar usuario 
#    actualizar con sl nuevo saldo
#    mandar correo
    redirect_to recargas_path, notice: mensaje
  end

  # GET /recargas/new
  def new
    @recarga = Recarga.new
  end

  # GET /recargas/1/edit
  def edit
    @usuario = User.find(@recarga.user_id)
  end

  # POST /recargas
  # POST /recargas.json
  def create
    #
    # rutina de enviar correo
    #
    @recarga = Recarga.new(recarga_params)
    @usuario = User.find(@recarga.user_id)
    respond_to do |format|
      if @recarga.save
        format.html { redirect_to @recarga, notice: 'La recarga fue cargada, se envió correo' }
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









        #
        # rutina de enviar correo
        #
        format.html { redirect_to @recarga, notice: 'Se ajustó la recarga, se envió correo' }
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










      #
      # rutina de enviar correo
      #
      format.html { redirect_to recargas_url, notice: 'Se borró la recarga' }
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
