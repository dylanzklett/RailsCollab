class User < ActiveRecord::Base
	attr_accessor :password
    has_attached_file :avatar
 	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
	has_many :posts
	has_many :comments 
	validates_presence_of :username
	validates_confirmation_of :password
	before_save :encrypt_password
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"


	def encrypt_password
		self.password_salt = BCrypt::Engine.generate_salt
		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
	end

	def self.authenticate(username, password)
		user = User.where(username: username).first
		if user && user.password_hash==BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end
end
