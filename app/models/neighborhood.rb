class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings

  def neighborhood_openings(date1, date2)
  end

  def self.highest_ratio_res_to_listings
    self.all.select{|n| n.listings.count > 0}.sort {|a, b| (a.reservation_count*10)/a.listings.count <=> (b.reservation_count*10)/b.listings.count}.last
  end

  def self.most_res
    neighborhood = self.all.sort {|a, b| a.reservation_count <=> b.reservation_count}.last
  end

  def reservation_count
    count = self.listings.collect{|listing| listing.reservations.count}.sum
  end

end
