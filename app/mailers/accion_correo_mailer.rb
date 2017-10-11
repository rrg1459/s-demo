class AccionCorreoMailer < ApplicationMailer
  default from: ENV["GMAIL_USER"]
  
  def recargado(user, recarga)
    buscar_saldo(user, recarga)
  	mail(to: @usuario.email, subject: 'Pre-recarga recibida y en proceso de verificación')
  end

  def ajustado(user, recarga)
    buscar_saldo(user, recarga)
  	mail(to: @usuario.email, subject: 'Pre-recarga ajustada y en proceso de verificación')
  end

  def aplicado(user, recarga)
    buscar_saldo(user, recarga)
  	mail(to: @usuario.email, subject: 'Se aplicó la pre-recarga')
  end

  def buscar_saldo(user, recarga)
    @modo = ENV["MODO"]
  	@usuario = user
  	if @modo == 'campanna'
      saldo = Saldo.find_by(usuario_id: 999999)
      @saldo = saldo.saldo
  	else
  	  @saldo = @usuario.saldo
  	end
  	@recarga = recarga
  end

end
