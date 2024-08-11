class User < ApplicationRecord
  before_create :set_full_name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #====================
  # Validations
  #====================
  validates_uniqueness_of :email

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
