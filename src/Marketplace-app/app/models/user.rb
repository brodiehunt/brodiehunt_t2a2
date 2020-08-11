class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :listings
  has_one :profile
  has_many :conversations_to_make, class_name: "Conversation", :foreign_key => "sender_id"
  has_many :conversations_to_recieve, class_name: "Conversation", :foreign_key => "recipient_id"
  has_many :messages, through: :conversation
end
