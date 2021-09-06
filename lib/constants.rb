module Constants
  PASSWORD_REQUIREMENTS = /\A
    (?=.{8,}) # At least 8 characters long
    (?=.*\d) # Contain at least one number
    (?=.*[a-z]) # Contain at least one lowercase letter
    (?=.*[A-Z]) # Contain at least one uppercase letter
    (?=.*[[:^alnum:]])
  /x.freeze
end
