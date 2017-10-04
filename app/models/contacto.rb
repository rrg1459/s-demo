class Contacto < ApplicationRecord

  has_and_belongs_to_many :grupos
  has_and_belongs_to_many :mensajes

  validates :nombre,      presence: { message: "en blanco" }, 
                length:   {minimum: 3, :message => "debe tener por lo menos 3 letras"}

  validates :numero,      presence: { message: "en blanco" },
             numericality: {message: "no es numérico"},
             length: { is: 10, :message => "debe tener 10 dígitos" },
             format: { with: /[4][1-2][2,4,6]/, message: "solo se aceptan los prefijos 412, 414, 424, 416 y 426" },
             uniqueness: { case_sensitive: false, message: "de contacto ya existe" }

  validates_numericality_of :numero, :greater_than_or_equal_to => 999999999, :message => ", el primer dígito tiene que ser 4"

  after_create   :actualizar_cgrupo
  after_update   :actualizar_todos_los_grupos
  after_destroy  :actualizar_todos_los_grupos

  self.per_page = 40

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << [column_names[1], column_names[2]]
      all.each do |contacto|
        csv << contacto.attributes.values_at(column_names[1], column_names[2])
      end
    end
  end
  
  def numero_nombre
    "(0#{numero[0,3]})#{numero[3,3]}-#{numero[6,7]} #{nombre}"
  end

end

