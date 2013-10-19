class Asset < ActiveRecord::Base
  validates :name, presence: true
  has_many :asset_versions
end
