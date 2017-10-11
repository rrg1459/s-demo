class Directo < ApplicationRecord
  validates :tlf,      presence: { message: "en blanco" },
             numericality: {message: "no es numérico"},
             length: { is: 10, :message => "debe tener 10 dígitos" },
             format: { with: /[4][1-2][2,4,6]/, message: "solo se aceptan los prefijos 412, 414, 424, 416 y 426" }
  validates_numericality_of :tlf, :greater_than_or_equal_to => 999999999, :message => ", el primer dígito tiene que ser 4"
  validates :sms,
    presence: { message: "en blanco" },
    length: { maximum: 160, :message => "muy largo" }
end

private
  def procesar_sms(di)
    directo = Directo.last
    cid = Contacto.find_by(numero: directo.tlf)
    cid = Contacto.create ( { "numero" => directo.tlf, "user_id" => di, "nombre" => "nombreTemporal#{Time.now.strftime("%j%L")}" } ) if !cid
    mid = Mensaje.create ( { "texto" => directo.sms, "user_id" => di, "cantidad_contactos" => 1 })
    ContactosMensaje.create( { "mensaje_id" => mid.id, "contacto_id" => cid.id })
    enviar_mensaje(mid.id)
    Directo.delete_all
  end

