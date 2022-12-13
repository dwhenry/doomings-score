require 'watir'
require 'webdrivers'
require 'nokogiri'
require 'mini_magick'

namespace :card_importer do
  desc "Import cards on other websites"
  task import: :environment do
    start_url = "https://www.worldofdoomlings.com/cards/echolocation-2"

    browser = Watir::Browser.new

    begin
      url = start_url
      browser.goto url

      while true do
        parsed_page = Nokogiri::HTML(browser.html)

        card = Card.find_or_create_by(name: parsed_page.css('.card-name').text)
        card.update(
          favour: parsed_page.css('.flavor-text').text,
          effect: (
            parsed_page.css('.effect-text div').map(&:text) -
              parsed_page.css('.effect-text.w-condition-invisible div'
          ).map(&:text)).select(&:presence).join("\n"),
          colour: parsed_page.css('.color .collection-list-wrapper-2').text,
          points: parsed_page.css('.points .property-pill').text,
          collection: parsed_page.css('.collections .property-pill').text,
          effects: {},
        )

        filename = Rails.root.join('app/assets/images/cards/', "#{card.name}.png")
        unless File.exists?(filename)
          `curl #{parsed_page.css('.card-detail-container .card-image-column img.card-detail-img').attribute('src')} > '#{filename}'`
        end

        types = [
          parsed_page.css('.card-type .property-pill').text,
          *(parsed_page.css('.subtype .property-pill .subtype-value').map(&:text))
        ]
        types.each do |type|
          type = Type.find_or_create_by(name: type)
          CardType.find_or_create_by(card: card, type: type)
        end
        puts card.name

        browser.div(class: 'next-block').link(class: 'prevnext-link-block').click
        sleep 0.2

        if browser.url == start_url
          exit
        end
      end
    ensure
      browser.close
    end
  end

  desc "Resize downloaded images to low res"
  task resize: :environment do
    Dir['app/assets/images/cards/*'].each do |file|
      next unless File.exist?(file)

      image = MiniMagick::Image.open(file)
      image.resize "15%"
      new_file_name = file.split('.').insert(-2, "small").join('.')
      image.write(new_file_name)
    end
  end
end
