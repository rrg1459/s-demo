Para el usuario final * * * * * * * * * * * * * * * * * * * - - - - - - - - - - - - - - 
*********************

Es importante correr rails db:seed a nivel del prompt del sistema

### en config environments production.rb
  config.action_mailer.default_url_options = { :host => '(nombre de la aplicacion)sms-demo.herokuapp.com' }

### en config initializers devise.rb
     correo del usuario final
  config.mailer_sender = 'por-favor-cambiame-para-inicializar-una-cuenta@ejemplo.com'

### en user modelo
  devise :invitable, :database_authenticatable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable


---------------------------------------------------------------------------------------------------------
Para el demo  * * * * * * * * * * * * * * * * * * * - - - - - - - - - - - - - - 
*********************
### en config environments production.rb
  config.action_mailer.default_url_options = { :host => 'sms-demo.herokuapp.com' }

### en config initializers devise.rb
  config.mailer_sender = 'por-favor-cambiame-para-inicializar-una-cuenta@ejemplo.com'

### en user modelo
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable
  
