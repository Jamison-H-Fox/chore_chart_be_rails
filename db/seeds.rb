# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

manifest_path = Rails.root.join("db", "loot_manifest.json")

unless File.exist?(manifest_path)
  puts "Skipping loot items: manifest.json not found at #{manifest_path}"
  puts "Expected it at db/loot_manifest.json."
else
  items = JSON.parse(File.read(manifest_path))
  puts "Seeding #{items.count} loot items..."

  items.each do |item|
    LootItem.find_or_create_by!(name: item["name"], rarity: item["rarity"]) do |li|
      li.collection = item["collection"]
      li.image_url  = item["image_url"]
    end
  end

  puts "Done. LootItem counts by rarity:"
  LootItem.group(:rarity).count.each { |rarity, count| puts "  #{rarity}: #{count}" }
end
