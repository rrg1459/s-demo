class PaginaController < ApplicationController
  before_action :saldo_sms, if: :user_signed_in?
  before_action :modo

  def terminos_condiciones
  	@valor = ENV["SMS_VALOR_ENVIADO"]
  	@favor = @valor.to_i * 10
  end

end



