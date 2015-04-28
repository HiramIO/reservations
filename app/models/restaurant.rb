class Restaurant < ActiveRecord::Base
  has_many :reservations
  has_many :users, through: :reservations

  def available?(party_size, start_time)
  reservations_for_time = reservations.where(start_time: start_time)
  reservations_for_time.sum(:party_size) + party_size <= capacity
  end
end
