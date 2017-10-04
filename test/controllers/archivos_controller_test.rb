require 'test_helper'

class ArchivosControllerTest < ActionDispatch::IntegrationTest
  test "should get cargar" do
    get archivos_cargar_url
    assert_response :success
  end

  test "should get listar_archivos" do
    get archivos_listar_archivos_url
    assert_response :success
  end

  test "should get borrar" do
    get archivos_borrar_url
    assert_response :success
  end

end
