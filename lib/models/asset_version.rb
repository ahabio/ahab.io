class AssetVersion < ActiveRecord::Base
  belongs_to :asset
  validates :value, presence: true, uniqueness: { scope: :asset_id }
  validates :url,   presence: true
end
