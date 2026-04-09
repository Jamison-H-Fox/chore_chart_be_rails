class LootItem < ApplicationRecord
  RARITIES = %w[common uncommon rare legendary].freeze

  validates :name,       presence: true
  validates :collection, presence: true
  validates :rarity,     presence: true, inclusion: { in: RARITIES }
  validates :image_url,  presence: true
  validates :name,       uniqueness: { scope: :rarity }
end
