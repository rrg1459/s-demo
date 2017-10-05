class MensajesController < ApplicationController

  before_action :set_mensaje, only: [:show, :alcance, :enviar, :edit, :update, :grupo, :destroy]
  before_action :authenticate_user!
  before_action :saldo_sms
  before_action :modo

  def new
    @mensaje = Mensaje.new
    agrupar
  end

  def create
    @mensaje = Mensaje.new(mensaje_params)
    @mensaje.user_id = current_user.id
    respond_to do |format|
      if @mensaje.save
        format.html { redirect_to new_mensaje_path, notice: 'Mensaje creado' }
      else
        agrupar
        format.html { render :new }
      end
    end
  end

  def show
    buscar_nombre
  end

  def alcance
    buscar_nombre
    mensaje = {"mensajes_id_in_any"=>[params[:id].to_s]}
    if @modo == 'campanna'
      @buscar = Contacto.search(mensaje)
    else  
      @buscar = Contacto.where(user_id: current_user.id).search(mensaje)
    end
    @contactos = @buscar.result(distinct: true).order("numero")
    @total = (@contactos = @buscar.result(distinct: true).order("numero")).length
  end

  def enviar
    capacidad_saldo(params[:id])
    if @capacidad 
      
#      capacidad_demo(params[:id])
#      enviar_mensaje(params[:id]) if @demo
       enviar_mensaje(params[:id])
    end
    redirect_to mensaje_path, notice: @mensaje
  end

  def edit
  end

  def update
    respond_to do |format|
      if @mensaje.update(mensaje_params)
        format.html { redirect_to '/', notice: 'mensaje editado' }
      else
        format.html { render :edit }
        format.json { render json: @contacto.errors, status: :unprocessable_entity }
      end
    end
  end

  def grupo
    respond_to do |format|
      if @mensaje.update(mensaje_params)
        actualizar_grupos(params[:id])
        format.html { redirect_to mensaje_path, notice: 'Alcance actualizado' }
      else
        format.html { render :show }
        format.json { render json: @contacto.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @mensaje.destroy
    respond_to do |format|
      format.html { redirect_to '/', notice: 'Mensaje borrado' }
    end
  end

  def buscar_nombre
    if User.exists?(@mensaje.enviado_por_id)
      nombre = User.find(@mensaje.enviado_por_id)
      @enviado_por = nombre.name.split(" ")
    end
  end

  private
  def set_mensaje
    @mensaje = Mensaje.find(params[:id])
  end
  
  def mensaje_params
    params.require(:mensaje).permit(:texto, :cantidad_contactos, grupo_ids:[])
  end

  def agrupar
    if @modo == 'campanna'
      @mensajes = Mensaje.all.order('updated_at DESC')
    else
      @mensajes = Mensaje.where(user_id: current_user.id).order('updated_at DESC')
    end
  end

end
