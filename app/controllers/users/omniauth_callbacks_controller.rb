class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def sparkwire
    @user = User.find_or_create_via_sparkwire_oauth(request.env["omniauth.auth"])

    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Sparkwire"
    sign_in_and_redirect @user, :event => :authentication
  end

  def failure
    render :text => 'failed'
  end
end
