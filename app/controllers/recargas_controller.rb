class RecargasController < ApplicationController
  before_action :authenticate_user!
  before_action :usuario_autorizado, except: [:recargar, :new]
  before_action :saldo_sms
  before_action :set_recarga, only: [:aplicar, :show, :edit, :update, :destroy]
  before_action :modo, only: :recargar





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
    @recargas = Recarga.all.order("user_id")
  end

  # GET /recargas/1
  # GET /recargas/1.json
  def show
    @usuario = User.find(@recarga.user_id) if @recarga.user_id != 999999
  end

  def recargar
    puts '1gggggggggggggggggggggggg'
    puts '2gggggggggggggggggggggggg'
    puts current_user.id
    puts params[:id]
    puts '3gggggggggggggggggggggggg'
    puts '4gggggggggggggggggggggggg'
    puts '5gggggggggggggggggggggggg'

    if @modo == 'campanna'
#              <li><%= link_to 'Pre recargar campaña', new_recarga_path %></li>
      redirect_to new_recarga_path
    else
      redirect_to root_url, notice: 'Solo puedes pre-cargar tu propio saldo' if current_user.id.to_i != params[:id].to_i
      @usuario = User.find(params[:id])
      @recarga = Recarga.new
    end
  end

  def aplicar
# verificar si es campanna    
#   @usuario = User.find(@recarga.user_id)







    if !@recarga.f_aplicado
      if @recarga.user_id == 999999
        @saldo = Saldo.find_by(usuario_id: 999999) 
        nuevo_saldo = @saldo.saldo + @recarga.monto_bs
        @saldo.update_columns(saldo: nuevo_saldo)
        mensaje = 'Recarga xxx fue aplicada a la campaña'
      else
        @usuario = User.find(@recarga.user_id)
        nuevo_saldo = @usuario.saldo + @recarga.monto_bs
        @usuario.update_columns(saldo: nuevo_saldo)
        mensaje = "Recarga fue aplicada al usuario: #{@usuario.username} "
      end
      AccionCorreoMailer.aplicado(@usuario, @recarga).deliver
      @recarga.update_columns(f_aplicado: Time.now)
    else
      mensaje = 'No se aplicó la recarga al usuario, porque ya estaba aplicada'
    end
    redirect_to recargas_path, notice: mensaje
  end

  # GET /recargas/new
  def new
    @recarga = Recarga.new
  end

  # GET /recargas/1/edit
  def edit
    @usuario = User.find(@recarga.user_id) if @recarga.user_id != 999999
  end

  # POST /recargas
  # POST /recargas.json
  def create
    @recarga = Recarga.new(recarga_params)
##    di = @recarga.user_id
##    di = 1 if di == 999999
##    @usuario = User.find(di)
    


    @usuario = User.first if @recarga.user_id == 999999



    respond_to do |format|
      if @recarga.save
        AccionCorreoMailer.recargado(@usuario, @recarga).deliver
        format.html { redirect_to @recarga, notice: 'La pre-recarga fue cargada, se envió correo' }
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
    di = @recarga.user_id
    di = 1 if di == 999999
    @usuario = User.find(di)
    respond_to do |format|
      if @recarga.update(recarga_params)
        AccionCorreoMailer.ajustado(@usuario, @recarga).deliver
        format.html { redirect_to @recarga, notice: 'Se ajustó la pre-recarga, se envió correo' }
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
      format.html { redirect_to recargas_url, notice: 'Se borró la pre-recarga' }
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
