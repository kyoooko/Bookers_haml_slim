class ApplicationController < ActionController::Base
  # deviseのコントローラーは基本application_controller
  # 登録、ログイン時の登録情報追加（deviseのデフォルトはメール、パス）
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :postal_code, :prefecture_code, :city, :street])
  end

  # deviseのメソッドで、ログイン後マイページに返す
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
end
