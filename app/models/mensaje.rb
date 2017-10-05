class Mensaje < ActiveRecord::Base

  has_and_belongs_to_many :grupos
  has_and_belongs_to_many :contactos

  require 'net/http'
  require 'uri'
  require 'openssl'
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  self.per_page = 20

  belongs_to :user

  validates :texto,
  presence: { message: "en blanco" },
  length: { maximum: 160, :message => "muy largo" }

  counter_culture :user
end

private
  def actualizar_grupos(di)
    contador = 0 
    vector = []
    gm = GruposMensaje.where(mensaje_id: di)
    gm.each do |gml|
      grp = Grupo.find(gml.grupo_id)
      cg = ContactosGrupo.where(grupo_id: grp.id) 
      cg.each do |cgl|
        contacto = Contacto.find(cgl.contacto_id)
        vector[contador] = contacto.id
        contador += 1
      end
    end
    vector = vector.sort.uniq
    total = vector.length
    mensaje = Mensaje.find(di)
    mensaje.update_columns(cantidad_contactos: total)
    mensaje.contactos.delete_all
    vector.each do |id_contacto|
      ContactosMensaje.create( { "mensaje_id" => di, "contacto_id" => id_contacto })
    end
  end

  def enviar_mensaje(di)
    total = 0
    mensaje = Mensaje.find(di)
    @sms = mensaje.texto
    cm = ContactosMensaje.where(mensaje_id: di)

    ciclo = 50 # maximo 100 por lista que es lo que permite la API

    todos = cm.length
    @uri = URI.parse("https://api.textveloper.com/sms/enviar/") 
    @uri = URI.parse("https://api.textveloper.com/sms/enviar/lista/") if todos > ciclo
    @request = Net::HTTP::Post.new(@uri) 
    contactos = []
    cm.each do |c|
      contacto = Contacto.find(c.contacto_id)
      tlfs = "0#{contacto.numero}"
      contactos[total] = tlfs
      total += 1
    end
    if todos > ciclo
      (0..todos - 1 ).each_slice(ciclo) do |x|
        @tlf = x.map { |_| contactos[_] }.join(",")
      end
    else
      numeros = (0..todos - 1).map { |num| num }
      @tlf = numeros.map { |_| contactos[_] }.join(",")
    end
    modo








#   enviar_sms








    total = total * @valor.to_i
    pedir_saldo
    @saldo.update_columns(saldo: (@saldo.saldo - total)) 
    mensaje.enviado_por_id = current_user.id
    mensaje.f_enviado = Time.now
    mensaje.save
    @mensaje = 'Mensaje enviado' 
  end

  def enviar_sms
=begin
    puts '======================'
    puts '-----enviar SMS-------'
    puts "uri: #{@uri}"
    puts "tlf: #{@tlf}"
    puts "sms: #{@sms}"
    puts "request: #{@request}"
    puts '-----enviar SMS-------'
    puts '======================'
=end
#=begin
    @request.set_form_data(
      "telefono" => @tlf,
      "mensaje" => "#{@sms}",
      "cuenta_token" => ENV["CUENTA_TOKEN"],
      "aplicacion_token" => ENV["APLICACION_TOKEN"]
    )
    req_options = { use_ssl: @uri.scheme == "https" }
    response = Net::HTTP.start(@uri.hostname, @uri.port, req_options) do |http|
      http.request(@request)
    end
    puts "response.code..: #{response.code}"
    puts "response.body..: #{response.body}"
#=end

  end

  def capacidad_demo(di)
    @mensaje = nil
    alto = 0
    gm = GruposMensaje.where(mensaje_id: di)
    gm.each do |gml|
      grp = Grupo.find(gml.grupo_id)
      cg = ContactosGrupo.where(grupo_id: grp.id) 
      contactos = cg.length
      alto = contactos if alto < contactos
    end
    grupos = gm.length   
    @demo = true
    @demo = false if alto > 3 || grupos > 2 
    @mensaje = "Estás en modo demo: Máximo 3 contactos por grupo" if alto > 3 
    @mensaje = "Estás en modo demo: Máximo 2 grupos  X mensaje" if grupos > 2 
  end

  def capacidad_saldo(di)
    if di == 999999
      total = 1
    else
      total = 0
      mensaje = Mensaje.find(di)
      cm = ContactosMensaje.where(mensaje_id: di)
      cm.each do |c|
        contacto = Contacto.find(c.contacto_id)
        total += 1
      end
    end
    total *= @valor.to_i
    modo
    pedir_saldo
    @capacidad = true
    @capacidad = false if total > @saldo.saldo
    @mensaje = 'El alcance supera su saldo, recargue su saldo para envíar este mensaje' if total > @saldo.saldo
  end

  def pedir_saldo
    if @modo = 'campanna'
      @saldo = Saldo.find_by(usuario_id: 999999) # aaa bbb ccc xxx zzz  ref application_controller linea 10
    else
      @saldo = Saldo.find_by(usuario_id: current_user.id) # aaa bbb ccc xxx zzz ref application_controller linea 10
    end  
  end
