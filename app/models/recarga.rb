class Recarga < ApplicationRecord
  belongs_to :user

  validates :monto_bs,      presence: { message: "en blanco" }, 
             length: {minimum: 4, :message => "debe tener por lo menos 4 dígitos"}

end
