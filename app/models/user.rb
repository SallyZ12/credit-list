class User < ActiveRecord::Base
  has_many :credits

  has_secure_password

  def self.find_by_slug(slug)
    User.all.detect{|user|user.slug == slug}
  end


  def slug
    username.downcase.gsub(" ","-")
  end


end
