class Ticket < ActiveRecord::Base
  attr_accessible :category, :user_id, :description, :status, :ticket_date
  belongs_to :user
  has_many :comments
end
