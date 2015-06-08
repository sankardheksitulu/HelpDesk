class Comment < ActiveRecord::Base
  attr_accessible :ticket_id, :user_id, :message
  belongs_to :ticket
end
