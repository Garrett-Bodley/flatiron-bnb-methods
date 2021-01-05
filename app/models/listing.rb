class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  
  validates :address, :listing_type, :title, :description, :price, :neighborhood, presence: true
  before_save :make_host_true
  before_destroy :make_host_false

  def average_review_rating
    self.reviews.collect{|r| r.rating}.sum.to_f/self.reviews.count.to_f
  end

  private

  def make_host_true
    self.host.update(host: true)
  end

  def make_host_false
    self.host.update(host: false) unless self.host.listings.count != 1
  end
end
