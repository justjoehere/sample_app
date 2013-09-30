class User < ActiveRecord::Base
  validates :name, presence: true,length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  #same as validates(:email,:presence=>"true", :format=>{:with=>VALID_EMAIL_REGEX},:uniqueness=>{:case_sensitive=>"false"})

  before_save { self.email = email.downcase }#ensures uniquness via same case inserts

  #attr_accessor :name, :email
  #for some reason the preceeding line causes an inability to save.  Not sure if this is ruby magic
  #where I've declared the name, email fields in the db creates issues when
  #you explicitly state them in this model class

end
