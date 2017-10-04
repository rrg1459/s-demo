class Grupo < ApplicationRecord
  has_and_belongs_to_many :contactos
  has_and_belongs_to_many :mensajes

  after_create   :actualizar_grupo
  after_update   :actualizar_grupo

	  validates :nombre,      presence: { message: "en blanco" }, 
                length:   {minimum: 3, :message => "debe tener por lo menos 3 letras"},
                uniqueness: { case_sensitive: false, message: "de grupo ya existe" }

  def nombre_cantidad
    "#{nombre}, #{cantidad_contactos} contactos"
  end

end

