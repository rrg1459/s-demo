class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def modo
    @modo = ENV["MODO"]
  end

  def saldo_sms
    modo
    @valor = ENV["SMS_VALOR_ENVIADO"]
    if @modo == 'campanna'
 #     @saldo = Saldo.find_by(usuario_id: 999999) # aaa bbb ccc xxx zzz  ref  mensaje modelo linea 76    
      @saldo = Saldo.last # aaa bbb ccc xxx zzz  ref  mensaje modelo linea 76    
      saldo = Saldo.last # aaa bbb ccc xxx zzz  ref  mensaje modelo linea 76    
      @saldo = saldo.saldo if saldo
    else
 #    @saldo = Saldo.find_by(usuario_id: current_user.id) # aaa bbb ccc xxx zzz ref mensaje modelo linea 76
      @saldo = current_user.saldo  
    end
  # @saldo = Saldo.create({"usuario_id" => current_user.id}) if !@saldo
    if !@saldo
      saldo = Saldo.create({"usuario_id" => 999999, "saldo" => 0})
      @saldo = saldo.saldo
    end
    @cupo = @saldo / @valor.to_i
    num   = @saldo % @valor.to_i
    @cupo += 1 if num > 0
  end

#  def cuota_sms
#    # no la elimino porque la logica para calcular un mes exacto me costo y me puede servir en el futuro
#    @sms = Sm.where(activo: true).first
#    if @sms.f_vencimiento > Time.now  
#      nil
#    else
#      dia   = @sms.f_inicial.strftime('%d')
#      mes   = @sms.f_vencimiento.strftime('%m')
#      anno  = @sms.f_vencimiento.strftime('%Y')
##     nueva = Time.new(anno, mes, dia)
#      nueva = @sms.f_vencimiento + (31*24*60*60)
#      nueva = @sms.f_vencimiento + (29*24*60*60) if mes == "01" && dia == "30" 
#      nueva = @sms.f_vencimiento + (28*24*60*60) if mes == "01" && dia == "31" 
#      nueva = @sms.f_vencimiento + (30*24*60*60) if mes == "01" && dia == "29" || ((mes == "03" || mes == "05" || mes == "08" || mes == "10") && dia == "31") 
#      nueva = nueva - (24*60*60)
#      @sms.update(f_vencimiento: nueva, usado: 0)
#    end
#  end  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :username, :password])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :username, :tos])
  end

private
  def usuario_autorizado
    redirect_to root_url unless current_user.email == 'rrg1459@hotmail.com' || current_user.email == 'rafa@com'
  end

end
