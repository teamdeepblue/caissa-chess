class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Added confirmable Sep 4,2016 -- Shreyams
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  protected
  # to skip required confirmation all-together, set below method to false
  def confirmation_required?
  	# false
  	true
  end
end
