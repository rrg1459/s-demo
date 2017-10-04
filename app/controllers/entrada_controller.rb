class EntradaController < ApplicationController
  before_action :authenticate_user!
  before_action :saldo_sms

  def index
#   @mensajes = Mensaje.all.paginate(page: params[:page]).order('updated_at DESC')
    @mensajes = Mensaje.all.order('updated_at DESC')
  end
  
  def diccionario
  end

  def premisas
  end
  
  def horario_sugerido
  end
  
end
