class User < ActiveRecord::Base
  validates :name, presence: true,length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  #same as validates(:email,:presence=>"true", :format=>{:with=>VALID_EMAIL_REGEX},:uniqueness=>{:case_sensitive=>"false"})

  before_save { self.email = email.downcase }#ensures uniquness via same case inserts
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
           class_name:  "Relationship",
           dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
    #Rails infers the association automatically: by default, Rails expects a
  # foreign key of the form <class>_id, where <class> is the lower-case version
  # of the class name.5 In the present case, although we are still dealing with users,
  # they are now identified with the foreign key follower_id, so we have to tell that to Rails




  #attr_accessor :name, :email
  #for some reason the preceeding line causes an inability to save.  Not sure if this is ruby magic
  #where I've declared the name, email fields in the db creates issues when
  #you explicitly state them in this model class

  has_secure_password
  validates :password, length: { minimum: 6 }

  before_create :create_remember_token
  #after_validation { self.errors.messages.delete(:password_digest) }

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  def following?(other_user)
    self.relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end
  def unfollow!(other_user)
    self.relationships.find_by(followed_id: other_user.id).destroy!
  end
  def feed
    Micropost.from_users_followed_by(self)
  end
private
  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end

end
