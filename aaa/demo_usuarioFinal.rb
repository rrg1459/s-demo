Para el usuario final * * * * * * * * * * * * * * * * * * * - - - - - - - - - - - - - - 
*********************

Es importante correo rails db:seed a nivel del prompt del sistema

### en config environments production.rb
  config.action_mailer.default_url_options = { :host => '(nombre de la aplicacion)sms-demo.herokuapp.com' }

### en config initializers devise.rb
     correo del usuario final
  config.mailer_sender = 'por-favor-cambiame-para-inicializar-una-cuenta@ejemplo.com'

### en views pagina index.html
...
<!--
        <h4>
          En el modo "demo" se puede crear una cuenta y enviar hasta <b>10 SMS gratuitos</b> a cualquier operadora, si está interesado en usar "Los Servicios" de esta página para sus requerimientos políticos, empresariales, sociales, o personales nos puede contactar por correo. 
        </h4>
-->
...
        <% if !User.take %>
...
        <% end %>
...

### en views parciales _navbar.html.erb
             <li><%= link_to 'Invitar a:', invitar_path if current_user.id == 1 %></li>

### en user modelo
  devise :invitable, :database_authenticatable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

### en mensaje controller  
  def enviar
    capacidad_saldo(params[:id])
    if @capacidad 
#       capacidad_demo(params[:id])
#       enviar_mensaje(params[:id]) if @demo
       enviar_mensaje(params[:id])
    end
    redirect_to mensaje_path, notice: @mensaje
  end

---------------------------------------------------------------------------------------------------------
Para el demo  * * * * * * * * * * * * * * * * * * * - - - - - - - - - - - - - - 
*********************
### en config environments production.rb
  config.action_mailer.default_url_options = { :host => 'sms-demo.herokuapp.com' }

### en config initializers devise.rb
  config.mailer_sender = 'por-favor-cambiame-para-inicializar-una-cuenta@ejemplo.com'

### en views pagina index.html
<!-- QUITAR ESTA LINEA
        <h4>
          En el modo "demo" se puede crear una cuenta y enviar hasta <b>10 SMS gratuitos</b> a cualquier operadora, si está interesado en usar "Los Servicios" de esta página para sus requerimientos políticos, empresariales, sociales, o personales nos puede contactar por correo. 
        </h4>
--> QUITAR ESTA LINEA
...
        <!% if !User.take %>
...
        <!% end %>
...

### en views parciales _navbar.html.erb
             <li><%= link_to 'Invitar a:', invitar_path %></li>

### en user modelo
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable
  
### en mensaje controller  
  def enviar
    capacidad_saldo(params[:id])
    if @capacidad
       capacidad_demo(params[:id])
       enviar_mensaje(params[:id]) if @demo
#       enviar_mensaje(params[:id])
    end
    redirect_to mensaje_path, notice: @mensaje
  end
