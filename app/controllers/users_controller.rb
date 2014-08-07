class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    if @user.notifications.length > 0
      flash.now[:message] = []
      @user.notifications.each do |notification|
        flash.now[:message] << {content: notification.content}
        if notification.project_id
          flash.now[:message].last[:project] = Project.find(notification.project_id)
        end
      end
    end
    @user.notifications.delete_all
    @user.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user]
    end
end
