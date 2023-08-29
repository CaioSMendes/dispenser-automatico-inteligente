class Administrador::UsersController < ApplicationController
    before_action :authenticate_admin! # Adicione um filtro para autenticar o administrador

  def index
    @users = User.where.not(id: current_user.id) # Exclui o próprio administrador da lista
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'Usuário atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to administrador_users_path, notice: 'Usuário excluído com sucesso.'
  end

  private

  def authenticate_admin!
    # Coloque aqui a lógica para verificar se o usuário atual é um administrador
    # Por exemplo, você pode ter um atributo "admin" no modelo User e verificar se ele é verdadeiro (true) aqui.
    # Além disso, verifique também se o usuário está logado para evitar acesso não autorizado.
  end
end
