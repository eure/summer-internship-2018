class Repositorie < ApplicationRecord
  validates :name, presence: true
  validates :type, presence: true
  validates :name, length: { maximum: 25 }
  validates :discription, length: { maximum: 255 }

  after_create :fetch_detail_data

  def fetch_detail_data
    html = open("https://github.com/#{name}")

    doc = Nokogiri::HTML.parse(html)
    readme = doc.css("#readme").to_s

    update!(readme: readme)
  end
end
