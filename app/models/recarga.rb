class Recarga < ApplicationRecord
  belongs_to :user

  validates :monto_bs,      presence: { message: "en blanco" }, 
             length: {minimum: 3, :message => "debe tener por lo menos 3 dígitos"}

end
