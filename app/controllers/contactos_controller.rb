class ContactosController < ApplicationController
  before_action :set_contacto, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :saldo_sms

  def index
    @buscar = Contacto.search(params[:q])
    @contactos = @buscar.result(distinct: true).order("numero")
    @total = @contactos.length
    respond_to do |format|
      format.html
      format.csv { send_data @contactos.to_csv }
      format.xls { send_data @contactos.to_csv(col_sep: "\t") }
    end
  end

  def show
    contacto = {"contactos_id_in_any"=>[params[:id].to_s]}
    @buscar = Mensaje.search(contacto)
    @mensajes = @buscar.result(distinct: true).order("created_at DESC")
  end

  def new
    @contacto = Contacto.new
  end

  def edit
  end

  def create
    @contacto = Contacto.new(contacto_params)

    respond_to do |format|
      if @contacto.save
        format.html { redirect_to @contacto, notice: 'El contacto fue creado' }
        format.json { render :show, status: :created, location: @contacto }
      else
        format.html { render :new }
        format.json { render json: @contacto.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @contacto.update(contacto_params)
        format.html { redirect_to @contacto, notice: 'El contacto fue actualizado' }
        format.json { render :show, status: :ok, location: @contacto }
      else
        format.html { render :edit }
        format.json { render json: @contacto.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contacto.destroy
    respond_to do |format|
      format.html { redirect_to contactos_url, notice: 'El contacto fue borrado' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contacto
      @contacto = Contacto.find(params[:id])
    end

    def contacto_params
      params.require(:contacto).permit(:nombre, :numero, :archivo, grupo_ids:[])
    end
end
