class UsersController < ApplicationController

  before_action :set_user, except: :invitar
  before_action :check_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :saldo_sms
  

  def show
    grupo = {"grupos_id_in_any"=>[params[:id].to_s]}
    @buscar = Contacto.search(grupo)
    @contactos = @buscar.result(distinct: true)
  end

  def invitar
    if params[:correo]
      User.invite!(:email => params[:correo], :username => params[:correo])
      redirect_to root_path, notice: "Invitación enviada a: #{params[:correo]}"
    end
  end

  def update
    if @user.email != params[:user][:email]
         @user.confirmed_at = nil
    end
    @user.update(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :password, :email)
  end

  def check_user
    if @user != current_user
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

end
