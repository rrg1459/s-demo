json.extract! recarga, :id, :monto_divisa, :tipo_divisa, :cambio_bs, :monto_bs, :banco_origen, :referencia_origen, :transaccion_origen, :banco_destino, :referencia_destino, :transaccion_destino, :aplicado, :user_id, :created_at, :updated_at
json.url recarga_url(recarga, format: :json)
