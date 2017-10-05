class GruposController < ApplicationController
  before_action :set_grupo, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :saldo_sms
  before_action :modo

  # GET /grupos
  # GET /grupos.json
  def index
    if @modo == 'campanna'
      @grupos = Grupo.all
    else
      @grupos = Grupo.where(user_id: current_user.id)
    end
    @total = @grupos.length
  end

  # GET /grupos/1
  # GET /grupos/1.json
  def show
    grupo = {"grupos_id_in_any"=>[params[:id].to_s]}
    if @modo == 'campanna'
      @buscar = Contacto.search(grupo)
    else
      @buscar = Contacto.where(user_id: current_user.id).search(grupo)
    end
    @contactos = @buscar.result(distinct: true).order("numero")
  end

  # GET /grupos/new
  def new
    @grupo = Grupo.new
    agrupar
  end

  # GET /grupos/1/edit
  def edit
    agrupar
  end

  # POST /grupos
  # POST /grupos.json
  def create
    @grupo = Grupo.new(grupo_params)
    @grupo.user_id = current_user.id

    respond_to do |format|
      if @grupo.save
        format.html { redirect_to @grupo, notice: 'Grupo creado' }
        format.json { render :show, status: :created, location: @grupo }
      else
        format.html { render :new }
        format.json { render json: @grupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /grupos/1
  # PATCH/PUT /grupos/1.json
  def update
    @grupo.user_id = current_user.id
    respond_to do |format|
      if @grupo.update(grupo_params)
        format.html { redirect_to @grupo, notice: 'Grupo editado' }
        format.json { render :show, status: :ok, location: @grupo }
      else
        format.html { render :edit }
        format.json { render json: @grupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /grupos/1
  # DELETE /grupos/1.json
  def destroy
    @grupo.destroy
    respond_to do |format|
      format.html { redirect_to grupos_url, notice: 'Grupo borrado' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grupo
      @grupo = Grupo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grupo_params
      params.require(:grupo).permit(:nombre, contacto_ids:[])
    end

    def agrupar
      if @modo == 'campanna'
        @contacto_cb = Contacto.all 
      else
        @contacto_cb = Contacto.where(user_id: current_user.id).order("numero")
      end
    end

end
