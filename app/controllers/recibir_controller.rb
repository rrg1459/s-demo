class RecibirController < ApplicationController

# before_action :authenticate_user!

  def sms
    if request.get? && params[:telefono]
#      puts '.......................'
#      params.each do |key,value|
#        Rails.logger.warn "Param #{key}: #{value}"
#      end
#      puts '.......................'
      if params[:telefono]
#       puts '***********************'
#       puts "telefono: #{params[:telefono]}"
#       puts "mensaje.: #{params[:mensaje]}"
        puts "*** recibiendo mensaje ***"
#       puts '***********************'
        tlf = params[:telefono].to_i 
        sms = params[:mensaje]
        cid = Contacto.find_by(numero: tlf)
        cid = Contacto.create ( { "numero" => tlf, "nombre" => "nombreTemporal#{Time.now.strftime("%j%L")}" } ) if !cid
        mid = Mensaje.create ( { "texto" => sms, "user_id" => 1, "cantidad_contactos" => 1 })
        ContactosMensaje.create( { "mensaje_id" => mid.id, "contacto_id" => cid.id })
      end

    end
  end
end
