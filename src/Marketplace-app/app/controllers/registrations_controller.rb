class RegistrationsController < Devise::RegistrationsController
  protected 

  # overriding the typical redirect after registration to create new profile page
  def after_sign_up_path_for(resource)
    new_profile_path
  end

end