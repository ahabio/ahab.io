class AssetVersion < ActiveRecord::Base
  has_one   :asset
  validates :value, presence: true, uniqueness: { scope: :asset_id }
  validates :url,   presence: true
end
