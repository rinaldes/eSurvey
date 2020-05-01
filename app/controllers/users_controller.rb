class UsersController < ApplicationController
  before_action :authenticate_admin, except: [:update_profile, :profile]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_users

  respond_to :html

  def index
    @fields = User.column_names
    filename = 'List Users on ' + DateTime.now.strftime("%d %B %Y %T").to_s
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @users.to_csv, filename: filename + '.csv'}
      format.xls do
        response.headers['Content-Disposition'] = 'attachment; filename="' + filename + '.xls"'
      end
    end
  end

  def show
    # respond_with(@user)
  end

  def new
    @user = User.new

    # respond_with(@user)
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      respond_to do |format|
        format.html { redirect_to users_path }
        format.js { render :create }
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.js { render :create }
      end
    end
    # respond_with(@user)
  end

  def update
    if @user.update(user_params)
      respond_to do |format|
        format.html { redirect_to users_path }
        format.js { render :update }
      end
    else
      respond_to do |format|
        format.html { render :index }
        format.js { render :update }
      end
    end
    # respond_with(@user)
  end

  def destroy
    target_status = params[:target_status] == "active" ? "active" : "inactive"
    @user.update_attribute(:status, target_status)
    respond_to do |format|
      format.html { redirect_to users_path }
      format.js { render :destroy }
    end
    # @user.destroy
    # respond_with(@user)
  end

  def search
    params_name = params[:name].upcase.gsub("'", "\\\'").gsub("\"", "\\\"")

    where_clauses = []
    where_clauses << "UPPER(email) LIKE '%#{params_name}%' OR UPPER(first_name) LIKE '%#{params_name}%' OR UPPER(last_name) LIKE '%#{params_name}%' OR UPPER(username) LIKE '%#{params_name}%'" if params_name.present?

    User.set_per_page(params[:per_page]) if params[:per_page].present?

    base_user = User.where(where_clauses.join(" AND "))
    @users_count = base_user.count
    @users = base_user.paginate(:page => params[:page])

    render :index
  end

  def profile
    @user = current_user
  end

  def update_profile
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path
    else
      render 'profile'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def set_users
      base_user = User.all
      @users_count = base_user.count
      @users = base_user.paginate(:page => params[:page])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :gender, :birth_place, :birth_date, :email, :username, :role, :status, :password, :password_confirmation, :image)
    end
end
