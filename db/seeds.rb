Beer.destroy_all
Style.destroy_all

BEERS = ["PBR", "Spiny the Elder", "Coors", "Heineken", "Avery IPA", "Epic IPA", "Breckenridge Lager", "Dogfish Double IPA"]
STYLES = ["IPA", "Lager", "Stout", "Belgian", "Bock", "Pale Ale"]
PRICES = ["4.99", "6.00", "7.11", "2.75", "4.50", "6.33", "7.25", "8.88", "9.13", "5.55"]

STYLES.each do |style|
  Style.create!(name: style)
end

BEERS.each do |beer|
    Beer.create!(name: beer, price: PRICES.sample, style: Style.find_by(name: STYLES.sample))
end
