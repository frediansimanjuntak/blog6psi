class User < ApplicationRecord
  has_many :articles
  has_secured_pasword

  validates :email, uniqueness: { case_sensitive: false}
  validates :username, uniqueness: { case_sensitive: false}
end
