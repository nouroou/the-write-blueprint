String parseSupabaseError(String rawError) {
  if (rawError.contains("Email not confirmed")) {
    return "Your email is not confirmed. Please check your inbox.";
  } else if (rawError.contains("invalid login credentials")) {
    return "Incorrect email or password. Please try again.";
  } else if (rawError.contains("User already exists")) {
    return "This email is already registered. Please log in or use a different email.";
  } else if (rawError.contains("Password should be at least")) {
    return "Your password is too weak. Please use a stronger password.";
  } else if (rawError.contains("Invalid email format")) {
    return "Please enter a valid email address.";
  }
  // Default fallback message
  return "An unexpected error occurred. Please try again.";
}
