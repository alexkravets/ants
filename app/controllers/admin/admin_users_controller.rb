module Admin
  class AdminUsersController < Admin::BaseController
    mongosteen

    def update_password
      user = resource
      new_password = permitted_params[:password]

      user.password = new_password
      user.password_confirmation = new_password

      if user.save
        if current_admin_user == user
          sign_in(user, bypass: true)
        end
        render nothing: true

      else
        render json: user.errors, status: 500

      end
    end

    protected

      def permitted_params
        params.permit!
      end

  end
end
