class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  attr_accessor :login

  validates :tos, acceptance: true # tos = terms_of_service

  self.per_page = 20

  devise :invitable, :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable


  validates :name, presence: { message: "Nombre en blanco" },
  length: { maximum: 40, :message => "Nombre muy largo" }

  validates :username, presence: { message: "Usuario en blanco" },
  length: { maximum: 12,  :message => "Nombre de usuario muy largo" },
  :uniqueness => { case_sensitive: false, message: "Usuario ya existe" }

  has_many :mensajes

  after_create :crea_saldo

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  protected
    def crea_saldo
      @modo = ENV["MODO"]
      if @modo != 'campanna'
        puts '........'
        @valor = ENV["SMS_VALOR_ENVIADO"]
        puts @valor
        puts '........'
        inicial = @valor.to_i * 10
        Saldo.create({"usuario_id" => self.id, "saldo" => inicial}) if @modo = 'demo'
      end
    end
end
