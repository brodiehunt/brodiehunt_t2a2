class Profile < ApplicationRecord
  belongs_to :user
  validates_presence_of :first_name, :last_name, :mobile_number, :user_id
end
