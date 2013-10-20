class AssetVersion < ActiveRecord::Base
  has_one   :asset
  validates :value, presence: true
end
