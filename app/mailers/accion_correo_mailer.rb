class AccionCorreoMailer < ApplicationMailer
  
  
  def recargado(user, recarga)
    @modo = ENV["MODO"]
  	@usuario = user
  	if @modo == 'campanna'
      saldo = Saldo.find_by(usuario_id: 999999)
      @saldo = saldo.saldo
  	else
  	  @saldo = @usuario.saldo
  	end
  	@recarga = recarga
  	mail(to: @usuario.email, subject: 'Recarga recibida y en proceso de verificación')
  end
end