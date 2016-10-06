module ApplicationHelper

  def auth_token  
    code = "<input type=\"hidden\" name=\"authenticity_token\" value=\"#{form_authenticity_token}\">"
    code.html_safe
  end
end
