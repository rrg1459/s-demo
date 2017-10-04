json.extract! contacto, :id, :numero, :nombre, :archivo, :created_at, :updated_at
json.url contacto_url(contacto, format: :json)
