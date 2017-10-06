FactoryGirl.define do
  factory :recarga do
    monto_divisa 1
    tipo_divisa "MyString"
    cambio_bs 1
    monto_bs 1
    banco_origen "MyString"
    referencia_origen "MyString"
    transaccion_origen "MyString"
    banco_destino "MyString"
    referencia_destino "MyString"
    transaccion_destino "MyString"
    aplicado false
    user nil
  end
end
