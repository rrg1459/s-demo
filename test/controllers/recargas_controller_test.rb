require 'test_helper'

class RecargasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @recarga = recargas(:one)
  end

  test "should get index" do
    get recargas_url
    assert_response :success
  end

  test "should get new" do
    get new_recarga_url
    assert_response :success
  end

  test "should create recarga" do
    assert_difference('Recarga.count') do
      post recargas_url, params: { recarga: { aplicado: @recarga.aplicado, banco_destino: @recarga.banco_destino, banco_origen: @recarga.banco_origen, cambio_bs: @recarga.cambio_bs, monto_bs: @recarga.monto_bs, monto_divisa: @recarga.monto_divisa, referencia_destino: @recarga.referencia_destino, referencia_origen: @recarga.referencia_origen, tipo_divisa: @recarga.tipo_divisa, transaccion_destino: @recarga.transaccion_destino, transaccion_origen: @recarga.transaccion_origen, user_id: @recarga.user_id } }
    end

    assert_redirected_to recarga_url(Recarga.last)
  end

  test "should show recarga" do
    get recarga_url(@recarga)
    assert_response :success
  end

  test "should get edit" do
    get edit_recarga_url(@recarga)
    assert_response :success
  end

  test "should update recarga" do
    patch recarga_url(@recarga), params: { recarga: { aplicado: @recarga.aplicado, banco_destino: @recarga.banco_destino, banco_origen: @recarga.banco_origen, cambio_bs: @recarga.cambio_bs, monto_bs: @recarga.monto_bs, monto_divisa: @recarga.monto_divisa, referencia_destino: @recarga.referencia_destino, referencia_origen: @recarga.referencia_origen, tipo_divisa: @recarga.tipo_divisa, transaccion_destino: @recarga.transaccion_destino, transaccion_origen: @recarga.transaccion_origen, user_id: @recarga.user_id } }
    assert_redirected_to recarga_url(@recarga)
  end

  test "should destroy recarga" do
    assert_difference('Recarga.count', -1) do
      delete recarga_url(@recarga)
    end

    assert_redirected_to recargas_url
  end
end
