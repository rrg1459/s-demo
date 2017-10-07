Para el usuario final * * * * * * * * * * * * * * * * * * * - - - - - - - - - - - - - - 
*********************

Es importante correr rails db:seed a nivel del prompt del sistema

### en config variables_de_ambiente.yml
  APLICACION_TOKEN: 50f2949a23fb510aac5100f0880784cff87bbcc5
...  
  GMAIL_USER: smsvene@gmail.com

### en config environments production.rb
  config.action_mailer.default_url_options = { :host => 'sigocontigo.herokuapp.com' }

### en config initializers devise.rb
  config.mailer_sender = 'juliopodemos@gmail.com'

### en modelo user despues que el usuario inicial (Julio) se cree en la pagina
  devise :invitable, :database_authenticatable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable


---------------------------------------------------------------------------------------------------------
Para el demo  * * * * * * * * * * * * * * * * * * * - - - - - - - - - - - - - - 
*********************

### en config variables_de_ambientes.yml

development:
  CUENTA_TOKEN: 44401a333598d4f8c502d721807c26df4e4402fb
  APLICACION_TOKEN: 50f2949a23fb510aac5100f0880784cff87bbcc5  /  sigocontigo
  SMS_VALOR_ENVIADO: "100"
  SMS_VALOR_RECIBIDO: "50"
  MODO: "demo"

production:
### en settings en heroku  CUENTA_TOKEN: 44401a333598d4f8c502d721807c26df4e4402fb
  CUENTA_TOKEN: 44401a333598d4f8c502d721807c26df4e4402fb
  APLICACION_TOKEN: 1db2f7c644627a98d9e6e0f6b2c4f658df42b922  /  demo
  GMAIL_USER: smsvene@gmail.com  /  sms.demo.ven@gmail.com
  GMAIL_PASSWORD: 0chPj9H2
  SMS_VALOR_ENVIADO: "100"
  SMS_VALOR_RECIBIDO: "50"
  MODO: "demo"

### en config environments production.rb
  config.action_mailer.default_url_options = { :host => 'sms-demo.herokuapp.com' }

### en config initializers devise.rb
  config.mailer_sender = 'por-favor-cambiame-para-inicializar-una-cuenta@ejemplo.com'

### en modelo user
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable
  
