class Messages

  # User Registration

  def self.registration_successful
    'User registered successfully'
  end

  def self.registration_failed(errors)
    'User not registered due to the following errors: ' + errors.join(", ")
  end

  # User Login

  def self.login_successful
    'Login successful'
  end

  def self.login_failed
    'User NOT found'
  end

  # User Update

  def self.update_email_failure
    'Update NOT successfull: The email cannot be changed'
  end

  def self.update_invalid_password
    'Update NOT successfull: The password cannot be empty'
  end

  def self.update_successful
    'Update successfull'
  end

  def self.update_failed(errors)
    'Update NOT successfull: ' + errors.join(", ")
  end

  # User password reset

  def self.password_reset_user_found
    'User found'
  end

  def self.password_reset_user_not_found
    'User not found. Password reset failure'
  end

end
