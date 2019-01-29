class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource
  
  # GET /users
  # GET /users.json
  def index
    if (user_signed_in?)
      if (current_user.admin?)
        @users = User.all
      else
        # User.where(["name = ? and email = ?", "Joe", "joe@example.com"])
        @users = User.where(["id = ?", current_user.id])
      end
    else
      redirect_to products_url, alert: 'Unauthorized access' 
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if (user_signed_in? && current_user.id != @user.id && !current_user.admin?)
      redirect_to products_url, alert: 'Unauthorized access'
    elsif (!user_signed_in?)
      redirect_to new_user_session_path
    end
  end

  # GET /users/new
  def new
    if (user_signed_in? && current_user.admin?)
      @user = User.new
    else
      redirect_to products_url, alert: 'Unauthorized access'
    end
  end

  # GET /users/1/edit
  def edit
    if (!user_signed_in? || !current_user.admin?)
      redirect_to products_url, alert: 'Unauthorized access'
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name)
    end
end
