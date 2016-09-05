class MyMailer < Devise::Mailer   
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  # overriding headers for confirmation instructions mail, Sep 4, 2016 -- Shreyams Jain
  def confirmation_instructions(record, token, opts={})
	  headers["Custom-header"] = "Bar"
	  opts[:from] = 'teamdeepblue@caissachess.com'
	  opts[:reply_to] = 'teamdeepblue@caissachess.com'
	  super
  end
end