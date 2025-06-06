class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def connect
    connected_user = User.find(params[:id])
    if current_user.connect(connected_user)
      flash[:notice] = "Connected to #{connected_user.email}."
    else
      flash[:alert] = "Unable to connect."
    end
    # redirect_to user_path(connected_user)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update(connected_user) }
    end
  end

  def disconnect
    disconnected_user = User.find(params[:id])
    connection = current_user.connections.find_by(connected_user: disconnected_user) ||
                 current_user.inverse_connections.find_by(user: disconnected_user)

    if connection
      connection.destroy
      flash[:notice] = "Disconnected from #{disconnected_user.email}."
    else
      flash[:alert] = "Unable to disconnect."
    end
    # redirect_to user_path(disconnected_user)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.update(disconnected_user) }
    end 
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username)
    end
end
