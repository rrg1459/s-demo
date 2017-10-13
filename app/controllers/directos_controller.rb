class DirectosController < ApplicationController
  before_action :authenticate_user!
  before_action :saldo_sms

  def new
    @directo = Directo.new
  end

  def create
    capacidad_saldo(888888)
    if @capacidad 
      @directo = Directo.new(params.require(:directo).permit(:tlf, :sms, :di))
      celular = params[:area] + params[:numero]
      @directo.tlf = celular
    	respond_to do |format|
        if @directo.save
          procesar_sms(current_user.id)
          format.html { redirect_to '/', notice: 'mensaje personal enviado' }
        else
          format.html { render :new }
        end
      end
    else
      redirect_to new_directo_url, notice: 'Recargue su saldo para poder envíar mensajes'
    end
  end
end
