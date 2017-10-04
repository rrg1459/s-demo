class PaginaController < ApplicationController
  before_action :saldo_sms, if: :user_signed_in?

  def terminos_condiciones
  	@valor = ENV["VALOR"]
  end

end



