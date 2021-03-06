Rails.application.routes.draw do
# get 'recibir/sms'

  get  'archivos/cargar'
  post 'archivos/cargar'
  post 'archivos/borrar'
# devise_for :users
  devise_for :users, controllers: { invitations: "invitations" }
  authenticated :user do
    root to: "mensajes#new", as: "entrada"
  end
  unauthenticated :user do
    root 'pagina#index'
  end
  resources :recargas
  resources :contactos
  resources :grupos
  resources :users, except: [:new, :create]
  resources :mensajes
  resources :directos, except: [:index, :show, :edit, :update, :destroy]

  post  '/mensajes/:id'          => 'mensajes#grupo',      as: 'mgrupo'
  post  '/enviar/:id'            => 'mensajes#enviar',     as: 'enviar'
  get   '/alcance/:id'           => 'mensajes#alcance',    as: 'alcance'
  match '/invitar/'              => 'users#invitar',       via: [:get, :post]
  get   '/usuarios/'             => 'recargas#usuarios'
  get   '/recargar/:id'          => 'recargas#recargar',   as: 'recargar'
  get   '/aplicar/:id'           => 'recargas#aplicar',    as: 'aplicar'
  get   '/recibir/'              => 'recibir#sms',         as: 'recibir'
  get   '/usuario/:id'           => 'recargas#usuario',    as: 'usuario'
  get   '/usar_sms/'             => 'pagina#usar_sms'
  get   '/terminos_condiciones/' => 'pagina#terminos_condiciones'
  get   '/diccionario/'          => 'entrada#diccionario' 
  get   '/premisas/'             => 'entrada#premisas' 
  get   '/horario_sugerido/'     => 'entrada#horario_sugerido' 
  get   '/horario_grafica/'      => 'entrada#horario_grafica' 
  get   '/horario_grafica100/'   => 'entrada#horario_grafica100' 
end
