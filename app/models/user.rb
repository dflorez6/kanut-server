class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  before_create :set_full_name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  #====================
  # Validations
  #====================
  validates_uniqueness_of :email
  validates :password_confirmation, presence: true, on: %i[create update]

  #====================
  # Associations
  #====================

  #====================
  # Uploaders
  #====================

  #====================
  # Scopes
  #====================
  default_scope { order(created_at: :desc) }

  #====================
  # Methods
  #====================
  # Custom method that concatenates first_name + last_name = name before create
  def set_full_name
    # TODO: Implement & Test Method
    # self.name = "#{self.first_name} #{self.last_name}"
  end
end
