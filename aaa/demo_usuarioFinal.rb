Para el usuario final * * * * * * * * * * * * * * * * * * * - - - - - - - - - - - - - - 
*********************

Es importante correr rails db:seed a nivel del prompt del sistema

### en config variables_de_ambiente.yml
  APLICACION_TOKEN: 50f2949a23fb510aac5100f0880784cff87bbcc5

### en config environments production.rb
  config.action_mailer.default_url_options = { :host => 'sigocontigo.herokuapp.com' }

### en config initializers devise.rb
     correo del usuario final
  config.mailer_sender = 'juliopodemos@gmail.com'

### en modelo user
  devise :invitable, :database_authenticatable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable


---------------------------------------------------------------------------------------------------------
Para el demo  * * * * * * * * * * * * * * * * * * * - - - - - - - - - - - - - - 
*********************

### en config variables_de_ambiente.yml
  APLICACION_TOKEN: 1db2f7c644627a98d9e6e0f6b2c4f658df42b922

### en config environments production.rb
  config.action_mailer.default_url_options = { :host => 'sms-demo.herokuapp.com' }

### en config initializers devise.rb
  config.mailer_sender = 'por-favor-cambiame-para-inicializar-una-cuenta@ejemplo.com'

### en modelo user
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable
  
