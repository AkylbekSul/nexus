# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :connections, foreign_key: :user_id, dependent: :destroy
  has_many :connected_users, through: :connections, source: :connected_user

  has_many :inverse_connections, class_name: "Connection", foreign_key: :connected_user_id, dependent: :destroy
  has_many :inverse_connected_users, through: :inverse_connections, source: :user

  # All connections (both direct and inverse)
  def all_connections
    connected_users + inverse_connected_users
  end

  # Connect to another user
  def connect(user)
    connections.create(connected_user: user)
  end

  # Disconnect from a user
  def disconnect(user)
    connections.find_by(connected_user: user)&.destroy
  end

  # Check if connected to another user
  def connected?(user)
    connected_users.include?(user) || inverse_connected_users.include?(user)
  end
end
